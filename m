Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbULXGJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbULXGJL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 01:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbULXGJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 01:09:10 -0500
Received: from web60606.mail.yahoo.com ([216.109.118.244]:61105 "HELO
	web60606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261376AbULXGJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 01:09:06 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=O0xCYAxi/S/DTqsTU5FRBBtxsvKg+ugqluhZ0gMf2YLOkK5Krqha/Se1WyDw6ugtfIvj3vTd6jMYHn4UVPtO5y+TR3kZ3XrVSxHn0qwxnLM1SAeGwVqlYEB3WLGA8cwKIrKwShAQldn3aTXSjxJRJRveWETKzToykYbhBepHGrk=  ;
Message-ID: <20041224060906.21085.qmail@web60606.mail.yahoo.com>
Date: Thu, 23 Dec 2004 22:09:06 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Re : Re: Intercepting system calls in Linux kernel 2.6.x 
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200412240540.iBO5ebvF015327@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
     I want to save the system call parameters in a
table. I want to do this from the kernel module. For
that, I want to replace the already existing system
call handler by my own. Are there any other mechanisms
for doing this without exporting system call table? If
it is then plz suggest any one of them?

Thanks,
selva
--- Valdis.Kletnieks@vt.edu wrote:

> On Thu, 23 Dec 2004 20:45:53 PST, selvakumar
> nagendran said:
> >  In linux kernel 2.6.x, what should we do to
> intercept
> > system calls? When I used sys_call_table from a
> > module, it returned the following error 'undefined
> > variable sys_call_table'. What is the way to
> export
> > system call table in kernel 2.6.x?
> 
> That's generally very deprecated.
> 
> What problem are you trying to solve by intercepting
> system calls? There
> may very well be some other way to achieve what
> you're trying to do...
> 

> ATTACHMENT part 2 application/pgp-signature 




		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250
