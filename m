Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268172AbUIWRWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268172AbUIWRWq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUIWRVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:21:30 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:38883 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268019AbUIWRTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:19:17 -0400
Subject: Re: Suggestion for CD filesystem for Backups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Judith und Mirko Kloppstech <jugal@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <415204E0.9010203@gmx.net>
References: <415204E0.9010203@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095956209.6776.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 23 Sep 2004 17:16:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-23 at 00:04, Judith und Mirko Kloppstech wrote:
> Why not write a file system on top of ISO9660 which uses the rest of the 
> CD to write error correction. If a sector becomes unreadable, the error 
> correction saves the data. Besides, a tool for testing the error rate 
> and the safety of the data can be easily written for a normal CD-ROM drive.
> 
> The data for error correction might be written into a file so that the 
> CD can be read using any System, but Linux provides error correction.

Send patches, or possibly if you are dumping tars and the like just
write yourself an app to generate a second file of ECC data.

