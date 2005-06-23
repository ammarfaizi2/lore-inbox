Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVFWE2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVFWE2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 00:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVFWE2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 00:28:09 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:37279 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S262066AbVFWE2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 00:28:01 -0400
Message-ID: <07be01c577a7$05108660$03c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Git Mailing List" <git@vger.kernel.org>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org> <42BA18AF.2070406@pobox.com> <Pine.LNX.4.58.0506221915280.11175@ppc970.osdl.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 23:52:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Wed, 22 Jun 2005, Jeff Garzik wrote:
>> git commit --figure-out-for-me-what-files-changed
>
> Well, it _does_ do that. That's what the "git status" thing does, and
> look at the initial commit message comments that it prepares for you: 
> it
> tells you which files are modified but haven't been marked for 
> check-in
> etc.
>
> But the thing is, you need to have a graphical tool for that. I don't
> want to have some silly command line that asks for each modified file
> whether you want to include that file in the commit or not.

I know I shouldn't invoke this particular acronym, but I rather like 
CVS's approach. If the user does not specify any files on the command 
line, assume he wants to check in everything that has changed (added and 
removed files excluded). When you see the initial commit message you can 
review the list of affected files and you can always abort and specify 
files explictly if you realize you want to exclude some.

I like that method because it gives you a kick in the pants for having 
mixed multiple unrelated changes in your working directory. "Oh, you 
were lazy and changed six unrelated things without comitting, eh? You 
will now pay for your lack of rigor by typing filenames..." On the flip 
side, you get rewarded with less typing if you keep your working 
directory clean.

--Adam

