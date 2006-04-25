Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWDYOtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWDYOtu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 10:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWDYOtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 10:49:50 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:7398 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932245AbWDYOtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 10:49:49 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Andi Kleen <ak@suse.de>
Cc: Neil Brown <neilb@suse.de>, Stephen Smalley <sds@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <200604251443.57885.ak@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <17485.55676.177514.848509@cse.unsw.edu.au>
	 <1145968949.17374.10.camel@moss-lions.epoch.ncsc.mil>
	 <200604251443.57885.ak@suse.de>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 25 Apr 2006 10:50:03 -0400
Message-Id: <1145976603.17374.15.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 14:43 +0200, Andi Kleen wrote:
> On Tuesday 25 April 2006 14:42, James Carter wrote:
> 
> > I talk to one of the unconfined people at the table and ask them to
> > rename the "knife" to "spoon".  Now I am free to do what I wish.
> 
> That assumes that your jail allows talking to other people. 
> 
> > You don't care about the name "knife", you care about the object it
> > represents.
> 
> In the apparmor model you only care about what the application is allowed
> to do. If it does anything extraordinary like trying to talk to people it 
> shouldn't talk to it gets a veto.

IIUC Apparmor does not confine IPC, so it can't stop an application from
talking to one it shouldn't.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

