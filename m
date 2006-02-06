Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWBFUlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWBFUlo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWBFUln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:41:43 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36993 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964811AbWBFUll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:41:41 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117155600.GF20632@sergelap.austin.ibm.com>
	<1137513818.14135.23.camel@localhost.localdomain>
	<1137518714.5526.8.camel@localhost.localdomain>
	<20060118045518.GB7292@kroah.com>
	<1137601395.7850.9.camel@localhost.localdomain>
	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
	<43D14578.6060801@watson.ibm.com>
	<Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>
	<43E21BD0.6000606@sw.ru> <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>
	<20060206201521.GA2470@ucw.cz> <43E7B35C.7090201@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 13:40:04 -0700
In-Reply-To: <43E7B35C.7090201@sw.ru> (Kirill Korotaev's message of "Mon, 06
 Feb 2006 23:36:44 +0300")
Message-ID: <m1psm0i5ln.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> This is exactly the reason why we allow host system to see all the
> containers/VPSs/processes.

Which makes for a really hairy, and noticably different logical implementation.
At least that was my impression when glancing at your patches.  I haven't
had a chance to look at them in depth yet.

> Otherwise monitoring tools should be fixed for it, which doesn't look good and
> top/ps/kill are not the only tools in the world.
> Without such functionality you can't understand whether you machine is
> underloaded or overloaded.

Look at my code please.  I think it is a place in the problem domain
you haven't considered.

Except for detailed information everything is there for existing tools.

Eric
