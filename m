Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265371AbTLHMUx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 07:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265382AbTLHMUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 07:20:53 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:20238 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S265371AbTLHMUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 07:20:52 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: oss.sgi.com: getting kgdb? 
In-reply-to: Your message of "Sun, 07 Dec 2003 22:03:58 BST."
             <20031207210358.GA305@elf.ucw.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Dec 2003 21:20:05 +1100
Message-ID: <1874.1070878805@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Dec 2003 22:03:58 +0100, 
Pavel Machek <pavel@ucw.cz> wrote:
>Hi!
>
>I'm trying to download latest kgdb from oss.sgi.com, but do not have
>much success:

kgdb is not on oss.sgi.com, it is on sourceforge.  kdb is on
oss.sgi.com.

>pavel@amd:~$ ftp oss.sgi.com
>Connected to oss.sgi.com.
>220---------- Welcome to Pure-FTPd ----------
>220-You are user number 9 of 50 allowed.
>220-Local time is now 12:57. Server port: 21.
>220 You will be disconnected after 15 minutes of inactivity.
>Name (oss.sgi.com:pavel): ftp
>[hang]

Path MTU problem somewhere between you and oss.sgi.com.  Issue
  ifconfig xxxx mtu 256
where xxxx is your outgoing interface name (eth0, ppp0 etc.) then start
the ftp session.

