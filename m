Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272164AbTG3HWJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 03:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272220AbTG3HWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 03:22:09 -0400
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:640 "EHLO dust")
	by vger.kernel.org with ESMTP id S272164AbTG3HWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 03:22:07 -0400
Date: Wed, 30 Jul 2003 02:25:53 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Studying MTD <studying_mtd@yahoo.com>
Cc: Joshua Kwan <joshk@triplehelix.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.6.0-test1 : modules not working
In-Reply-To: <20030730065007.93696.qmail@web20501.mail.yahoo.com>
Message-ID: <Pine.LNX.4.56.0307300223300.4665@dust>
References: <20030730065007.93696.qmail@web20501.mail.yahoo.com>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, Studying MTD wrote:

> I tried hello world example from
> http://lwn.net/Articles/21817/
> 
> but i am still getting :-
> 
> #insmod hello_module.o
> No module found in object
> Error inserting 'hello_module.o': -1 Invalid module
> format

[Snip]

'kay.  So modules are enabled and everything.  More specifically, I was 
after information such as the gcc options and stuff you used to compile 
hello_module.o

Check the second article at that URL, and try building your hello_module
with the basic Makefile it gives.  That uses the best way for building
external modules.  After building your kernel that way, try inserting the
hello_module.ko.

-- 
Alex Goddard
agoddard@purdue.edu
