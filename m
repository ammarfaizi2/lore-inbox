Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267903AbUH2OUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267903AbUH2OUO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 10:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267893AbUH2OUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 10:20:14 -0400
Received: from the-village.bc.nu ([81.2.110.252]:57216 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267903AbUH2OUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 10:20:11 -0400
Subject: Re: hpt366.c: wrong timings used since 2.6.8
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Folke Ashberg <folke@ashberg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040826223617.GA4557@ashberg.de>
References: <20040826223617.GA4557@ashberg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093785484.27935.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 14:18:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-26 at 23:36, Folke Ashberg wrote:
> I saw that hpt366.c got support for HPT372_N_ and its special timings, but
> that timings have been used for my HPT372_A_ and caused the Oops.

The change you suggest is definitely wrong and will cause disk
corruption on the 372N

> I did the following and now it works:

Please post the actual oops data and if you can the rid/did.  The 372N
is identified by two things - PCI ID _or_ RID/DID. Not all 372N cards
have the unique PCI ID.

