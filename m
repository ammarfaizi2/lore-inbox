Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317037AbSFKNUO>; Tue, 11 Jun 2002 09:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317040AbSFKNUN>; Tue, 11 Jun 2002 09:20:13 -0400
Received: from hera.cwi.nl ([192.16.191.8]:22662 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S317037AbSFKNUM>;
	Tue, 11 Jun 2002 09:20:12 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 11 Jun 2002 15:20:11 +0200 (MEST)
Message-Id: <UTC200206111320.g5BDKB819045.aeb@smtp.cwi.nl>
To: davej@suse.de, kaos@ocs.com.au
Subject: Re: 2.5.21 no source for several objects
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> obj-$(CONFIG_EISA)              += eisa.o

> It should bite as soon as someone tries to compile a kernel with EISA

Yes, and it does.

On the other hand, yesterday I did some more SCSI stuff
and deleted constants.h. The build failed because constants.h
could not be found. And "make depend" does not do anything
anymore.

What should I have done (instead of the "make mrproper"
that of course worked)?

Andries
