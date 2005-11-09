Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161260AbVKIWCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161260AbVKIWCS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161254AbVKIWCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:02:18 -0500
Received: from ns.firmix.at ([62.141.48.66]:2755 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1161265AbVKIWCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:02:17 -0500
Subject: Re: typedefs and structs
From: Bernd Petrovitsch <bernd@firmix.at>
To: Andreas Schwab <schwab@suse.de>
Cc: thockin@hockin.org, linas <linas@austin.ibm.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       "J.A. Magallon" <jamagallon@able.es>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Douglas McNaught <doug@mcnaught.org>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net, linuxppc64-dev@ozlabs.org
In-Reply-To: <jelkzxqyie.fsf@sykes.suse.de>
References: <B68D1F72-F433-4E94-B755-98808482809D@mac.com>
	 <20051109003048.GK19593@austin.ibm.com>
	 <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local>
	 <20051109004808.GM19593@austin.ibm.com>
	 <19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com>
	 <20051109111640.757f399a@werewolf.auna.net>
	 <Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net>
	 <20051109192028.GP19593@austin.ibm.com> <20051109193625.GA31889@hockin.org>
	 <20051109193828.GR19593@austin.ibm.com> <20051109203954.GA3539@hockin.org>
	 <jelkzxqyie.fsf@sykes.suse.de>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Wed, 09 Nov 2005 23:00:50 +0100
Message-Id: <1131573650.3258.2.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 22:53 +0100, Andreas Schwab wrote:
> thockin@hockin.org writes:
> 
> > Sigh, That's funny - I've written C++ code which has references as members
> > of objects.  You absolutely *can* store a reference.
> 
> You can _initialize_, but not _modify_ (reseat) it.
                                          reset?
As in:
----  snip  ----
struct x {
	struct y * const p;
};
----  snip  ----

We assume that no one casts the "const" away.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



