Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbTBKJGJ>; Tue, 11 Feb 2003 04:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbTBKJGJ>; Tue, 11 Feb 2003 04:06:09 -0500
Received: from mail.permas.de ([195.143.204.226]:48303 "EHLO netserv.local")
	by vger.kernel.org with ESMTP id <S267106AbTBKJGI>;
	Tue, 11 Feb 2003 04:06:08 -0500
From: Hartmut Manz <manz@intes.de>
Organization: INTES GmbH
To: linux-kernel@vger.kernel.org
Subject: allocate more than 2 GB on IA32
Date: Tue, 11 Feb 2003 10:15:54 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302111015.54223.manz@intes.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i would like to allocate more than 2 GB of memory on an IA32 architecture.

The machine is a dual XEON_DP with 3 GB of Ram and 4 GB of swap space.

I have tried with the default SUSE 8.1 kernel as well as with a
2.4.20-pre4aa1 Kernel compile by my own using these Options:

CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_1GB=y

but I am only able to allocate 2 GB with a single malloc call.
I tought it should be possible to allocate up to 2.9 GB of memory to a
process, with this kernel settings.

Thank You for any help

Hartmut Manz

-- 
-----------------------------------------------------------------------------
Hartmut Manz                                      WWW:    http://www.intes.de
INTES GmbH                                        Phone:  +49-711-78499-29
Schulze-Delitzsch-Str. 16                         Fax:    +49-711-78499-10
D-70565 Stuttgart                                 E-mail: manz@intes.de
   Ein Mensch sieht, was vor Augen ist; der Herr aber sieht das Herz an.
------------------------------------------------------- 1. Samuel 16, 7 -----

