Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbSKNRfJ>; Thu, 14 Nov 2002 12:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbSKNRfI>; Thu, 14 Nov 2002 12:35:08 -0500
Received: from kim.it.uu.se ([130.238.12.178]:62932 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S265074AbSKNRfH>;
	Thu, 14 Nov 2002 12:35:07 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15827.57443.872245.136344@kim.it.uu.se>
Date: Thu, 14 Nov 2002 18:41:55 +0100
To: Daniel Podlejski <underley@underley.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dell Poweredge 2600 SMP
In-Reply-To: <20021114171431.GA22647@witch.underley.eu.org>
References: <20021114171431.GA22647@witch.underley.eu.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Podlejski writes:
 > Any ideas why Linux 2.4.19, 2.4.20-rc1 and -rc1-ac1 with megaraid
 > driver from http://www.domsch.com/linux/megaraid/ detects four CPUs,
 > when olny two are on board ?

Because
1) it has two hyperthreaded Xeon processors, each of which contains
   two logical CPUs, and
2) you didn't disable hyperthreading in the BIOS.

Sigh. This is becoming a FAQ...
