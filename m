Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbTDHTwn (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTDHTwn (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:52:43 -0400
Received: from air-2.osdl.org ([65.172.181.6]:33727 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261675AbTDHTwl (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 15:52:41 -0400
Date: Tue, 8 Apr 2003 13:03:48 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "shesha bhushan" <bhushan_vadulas@hotmail.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: KERNEL PROFILING
Message-Id: <20030408130348.11e3946b.rddunlap@osdl.org>
In-Reply-To: <F20Lig41UjdSkleUBUh0001d797@hotmail.com>
References: <F20Lig41UjdSkleUBUh0001d797@hotmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know why it's not created.

What kernel version is this?  Did you build the kernel
or is it from someone else who could have modified it?

The only failure that I see in profile setup/init is Out of Memory
if the profile buffer cannot be allocated.  Did you search thru
the boot message log for any errors?

~Randy


On Tue, 08 Apr 2003 19:42:03 +0000 "shesha bhushan" <bhushan_vadulas@hotmail.com> wrote:

| 
| Hi
| If I use the command line option "profile=2" while booting the system, why 
| /proc/profile file is not created? Should I have to create it manually?
| 
| Thanking You'
| Shesha
| 
| 
| 
| 
| 
| >From: "Randy.Dunlap" <rddunlap@osdl.org>
| >To: "shesha bhushan" <bhushan_vadulas@hotmail.com>
| >CC: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
| >Subject: Re: KERNEL PROFILING
| >Date: Tue, 8 Apr 2003 08:01:55 -0700
| >
| >On Tue, 08 Apr 2003 07:58:54 +0000 "shesha bhushan" 
| ><bhushan_vadulas@hotmail.com> wrote:
| >
| >| HI ALL,
| >|   I am trying to profile the linux kernel. Can any one suggest an easy 
| >way
| >| to do. Like, I wanted to see how much TCP is using CPU, how much of CPU 
| >is
| >| used in memcpy, etc.
| >| Can any one please suggest me.
| >
| >Start with the file linux/Documentation/basic_profiling.txt
| >(it's in Linux 2.5.66-or-so or later).
| >
| >It explains how to use oprofile and readprofile.
| >
| >You can read about oprofile at http://oprofile.sourceforge.net/ .
| >
| >You can read about basic in-kernel profiling using /proc/profile
| >and readprofile via 'man readprofile'.  It's simple to use.
| >
| >--
| >~Randy
