Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTFPHTD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 03:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTFPHTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 03:19:03 -0400
Received: from snickers.hotpop.com ([204.57.55.49]:60546 "EHLO
	snickers.hotpop.com") by vger.kernel.org with ESMTP id S263461AbTFPHTA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 03:19:00 -0400
Subject: Re: 2.4 Bitkeeper repo not updated ?
From: Weitai Liu <weitailiu@hotpop.com>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200306161245.33196.mflt1@micrologica.com.hk>
References: <200306161245.33196.mflt1@micrologica.com.hk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Jun 2003 15:30:01 -0400
Message-Id: <1055791813.744.69.camel@lwt>
Mime-Version: 1.0
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-16 at 02:00, Michael Frank wrote:
> 2.4.21 seems not be at  http://linux.bkbits.net/linux-2.4
> Tried yesterday and again today
> 
> Also tag for -rc8 is missing
> 
I have cloned  2.4 from this site at this morning , 2.4.21  is there:

#! /bin/sh -v
bk clone bk://linux.bkbits.net/linux-2.4

cd linux-2.4
. ../bkresync
cd ..


Makefile content :
 
VERSION = 2
PATCHLEVEL = 4
SUBLEVEL = 21
EXTRAVERSION = -rc8

KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)
KERNELPATH=kernel-$(shell echo $(KERNELRELEASE) | sed -e "s/-//g")


LWT


