Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279884AbRJ3JPh>; Tue, 30 Oct 2001 04:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279898AbRJ3JP2>; Tue, 30 Oct 2001 04:15:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10513 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279886AbRJ3JPS>; Tue, 30 Oct 2001 04:15:18 -0500
Subject: Re: Module Licensing?
To: kwooten@home.com (Kevin D. Wooten)
Date: Tue, 30 Oct 2001 09:22:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01102920463500.03524@newton.cevio.com> from "Kevin D. Wooten" at Oct 29, 2001 08:46:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yV6P-0005sD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After reading the posts about the MODULE_LICENSE macro, I am in disbelief. I 
> was under the impression that one could write a "closed-source" module and 
> distribute it in binary form, and be in compliance. Please tell me I am 

Providing your work constitutes a seperate work that isn't a derivative
work. Thats a lawyer definition and one for lawyers

> wrong? We use Linux as a platform for some data acquisition, and we are 
> currently distributing ( in very limited quantity to people who would already 
> have signed an NDA ) modules that currently have no official license as yet.
> We are researching which license to use, but according to these post's we 
> have almost no choice, Open Source or not at all!

The tag is purely so we can tell free stuff apart. If you tag a module

MODULE_LICENSE("(c) Copyright EvilCorp, All rights wronged");

it will still load but the user will be advised not to report bugs to the
kernel lists and the like. The oops data will similarly be marked "tainted"
so that we can discard it.

It's a filter so we don't have to handle bugs in your driver, nothing more.
