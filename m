Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267678AbTAMAgO>; Sun, 12 Jan 2003 19:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267682AbTAMAgO>; Sun, 12 Jan 2003 19:36:14 -0500
Received: from rj.SGI.COM ([192.82.208.96]:3783 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S267678AbTAMAgN>;
	Sun, 12 Jan 2003 19:36:13 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Edward Kuns <ekuns@kilroy.chi.il.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel oops in 2.4.21-pre3-ac2 
In-reply-to: Your message of "12 Jan 2003 17:47:31 MDT."
             <1042415250.1602.14.camel@kilroy.chi.il.us> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Jan 2003 11:44:33 +1100
Message-ID: <2443.1042418673@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jan 2003 17:47:31 -0600, 
Edward Kuns <ekuns@kilroy.chi.il.us> wrote:
>Rebooted into the same kerne so I could run ksymoops.  Looked in
>/var/log/messages and found two OOPses.  They are decoded below.  I
>don't know why I got the various "cannot stat(....)" lines, nor why I
>got the complaints "cannot match loaded modile raid0 to a unique module
>object" (and same for ehci-hcd).

ksymoops -i when loading modules from a ramdisk.  man ksymoops for the
reason.

