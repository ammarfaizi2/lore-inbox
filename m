Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161223AbVKIU3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbVKIU3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 15:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161225AbVKIU3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 15:29:36 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:35026 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1161223AbVKIU3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 15:29:35 -0500
Date: Wed, 9 Nov 2005 12:39:54 -0800
From: thockin@hockin.org
To: linas <linas@austin.ibm.com>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>,
       "J.A. Magallon" <jamagallon@able.es>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Douglas McNaught <doug@mcnaught.org>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc64-dev@ozlabs.org
Subject: Re: typedefs and structs
Message-ID: <20051109203954.GA3539@hockin.org>
References: <B68D1F72-F433-4E94-B755-98808482809D@mac.com> <20051109003048.GK19593@austin.ibm.com> <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local> <20051109004808.GM19593@austin.ibm.com> <19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com> <20051109111640.757f399a@werewolf.auna.net> <Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net> <20051109192028.GP19593@austin.ibm.com> <20051109193625.GA31889@hockin.org> <20051109193828.GR19593@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109193828.GR19593@austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 01:38:28PM -0600, linas wrote:
> On Wed, Nov 09, 2005 at 11:36:25AM -0800, thockin@hockin.org was heard to remark:
> > Umm, references are implemented as pointers.  Instead of a "zoo of
> > pointers" you have a "zoo of references".  No functional difference.
> 
> Sigh.
> 
> I think you are confusing references and pointers. By definition
> you cannot "store a reference"; however, you can "dereference"
> an object and store a pointer to it.


Sigh, That's funny - I've written C++ code which has references as members
of objects.  You absolutely *can* store a reference.

References are simply a syntactic simplification to eliminate the
different pointer-dereference notation.  If they make you think about a
problem differently, that's fine, but they are really just pointers in
disguise.
