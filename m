Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbTKJNWb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTKJNWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:22:31 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:29417 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263577AbTKJNWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:22:30 -0500
Date: Mon, 10 Nov 2003 14:22:23 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Lars Ehrhardt <1103@ng.h42.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling 2.6.0-test9 with Stack Overflow Detection Support fails on sparc64
Message-ID: <20031110132223.GB12099@wohnheim.fh-wedel.de>
References: <3FAF8FE0.30908@ng.h42.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FAF8FE0.30908@ng.h42.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 November 2003 14:17:20 +0100, Lars Ehrhardt wrote:
> 
> trying to compile kernel 2.6.0-test9 with the Stack Overflow Detection
> Support option set to yes does not work on sparc64 gcc version 3.3.2
> (Debian).
> 
> The output from make is:
> 
> CC      scripts/empty.o
> gcc: -pg and -fomit-frame-pointer are incompatible
> make[1]: *** [scripts/empty.o] Error 1
> make: *** [scripts] Error 2

Then get rid of all -fomit-frame-pointer options in the Makefile.

Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster
