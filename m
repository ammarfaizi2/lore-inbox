Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266528AbSKZSAD>; Tue, 26 Nov 2002 13:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266537AbSKZSAD>; Tue, 26 Nov 2002 13:00:03 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:36498 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266528AbSKZSAB>; Tue, 26 Nov 2002 13:00:01 -0500
Subject: Re: 2.5.49: "hdb: cannot handle device with more than 16 heads"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ebuddington@wesleyan.edu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021126125019.A81@ma-northadams1b-112.nad.adelphia.net>
References: <20021126125019.A81@ma-northadams1b-112.nad.adelphia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Nov 2002 18:38:25 +0000
Message-Id: <1038335905.2658.65.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-26 at 17:50, Eric Buddington wrote:
> This is 2.5.49, compiled for i386 with almost all modules using
> gcc-3.2.  On my PII Omnibook 4100, the messages stop after the first
> hda: message (where it would normally identify the drive). The same
> problem existed in 2.4.48.
> 
> When booting on my Athlon (hda:Maxtor 5T040H4, hdb: Maxtor 90840D6), I
> get the following boot messages:

Looks like you used the old MFM/RLL driver for hda. That wont work with
new drives. 

