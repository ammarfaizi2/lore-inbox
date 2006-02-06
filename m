Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWBFUPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWBFUPh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWBFUPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:15:36 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30468 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932370AbWBFUPf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:15:35 -0500
Date: Mon, 6 Feb 2006 20:15:21 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
Message-ID: <20060206201521.GA2470@ucw.cz>
References: <20060117155600.GF20632@sergelap.austin.ibm.com> <1137513818.14135.23.camel@localhost.localdomain> <1137518714.5526.8.camel@localhost.localdomain> <20060118045518.GB7292@kroah.com> <1137601395.7850.9.camel@localhost.localdomain> <m1fyniomw2.fsf@ebiederm.dsl.xmission.com> <43D14578.6060801@watson.ibm.com> <Pine.LNX.4.64.0601311248180.7301@g5.osdl.org> <43E21BD0.6000606@sw.ru> <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> There are two issues here.
> 1) Monitoring.  (ps, top etc)
> 2) Control (kill).
> 
> For monitoring you might need to patch ps/top a little but it is doable without
> 2 pids.
> 
> For kill it is extremely rude to kill processes inside of a nested pid space.
> There are other solutions to the problem.

Can you elaborate? If I have 10 containers with 1000 processes each,
it would be nice to be able to run top then kill 40 top cpu hogs....
-- 
Thanks, Sharp!
