Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315327AbSEGETn>; Tue, 7 May 2002 00:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315328AbSEGETm>; Tue, 7 May 2002 00:19:42 -0400
Received: from zok.SGI.COM ([204.94.215.101]:18560 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315327AbSEGETl>;
	Tue, 7 May 2002 00:19:41 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.14 -- dmesg corruption -- Error seeking in /dev/kmem, Symbol #floppy, value d990e000, Error adding kernel module table entry 
In-Reply-To: Your message of "Mon, 06 May 2002 02:33:05 MST."
             <3CD64DD1.2030009@megapathdsl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 May 2002 14:19:27 +1000
Message-ID: <22663.1020745167@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 May 2002 02:33:05 -0700, 
Miles Lane <miles@megapathdsl.net> wrote:
>I have reported this at least twice before.  At least one
>other person has reported reproducing this problem.
>Would someone please care enough to help me track this
>down?

It is the old klogd code that tries to decode oops and rarely gets it
right.  Start klogd as 'klogd -x'.

