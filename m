Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVADQGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVADQGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVADQGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:06:00 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:32523 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261688AbVADQFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:05:50 -0500
Date: Tue, 4 Jan 2005 23:58:11 +0800 (WST)
From: raven@themaw.net
To: autofs mailing list <autofs@linux.kernel.org>
cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] autofs4 2.4 updated module build kit and kernel patches
Message-ID: <Pine.LNX.4.61.0501042238370.20210@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-98.1, required 8,
	NO_REAL_NAME, RCVD_IN_ORBS, RCVD_IN_OSIRUSOFT_COM, USER_AGENT_PINE,
	USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I have updated the autofs4 kernel module patches to match the 
implementation in 2.6.10.

The most significant change is the addition of code to handle compatible 
ioctls for architectures that need it. It is important for systems like 
Gentoo or Debian on Ultra sparc, for example.

The files are located in:

http://www.kernel.org/pub/linux/daemons/autofs/v4

and are

the build kit:
     autofs4-2.4-module-20041227.tar.[bz2|gz]

vanila kernel patches:
     autofs4-2.4.18-20041227.patch
     autofs4-2.4.19-20041227.patch
     autofs4-2.4.20-20041227.patch
     autofs4-2.4.21-20041227.patch
     autofs4-2.4.22-20041227.patch
     autofs4-2.4.27-20041227.patch

RedHat 9:
     autofs4-2.4.20-redhat9-20041227.patch

Fedora Core 1:
     autofs4-2.4.22-fc1-20041227.patch


Ian



