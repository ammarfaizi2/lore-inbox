Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286704AbRL1DSE>; Thu, 27 Dec 2001 22:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286708AbRL1DRy>; Thu, 27 Dec 2001 22:17:54 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:13575
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S286704AbRL1DRn>; Thu, 27 Dec 2001 22:17:43 -0500
Date: Thu, 27 Dec 2001 19:16:15 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: Guolin@alexa.com, linux-kernel@vger.kernel.org
Subject: Re: where is the patch  ide.2.4.14.11062001.patch, for supporting
 EID E ata133 ??
In-Reply-To: <200112271813.KAA30020@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.10.10112271854180.24491-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Adam J. Richter wrote:

> >I will not merge until I can DOMAIN VALIDATE the pile of SHIT called 2.5.X
> 
> 	I would be interested in knowing what "domain validate" means
> and how was done in previous kernels.

"DOMAIN VALIDATION" is to test by emperical means and verification by bus
analyzers considered standard to a given industry.

In storage it means to have access/creation of the low_level transport
layer to the hardware and be able to verify all the capablities of the
hardware.  This is regardless if you use them or not.

Linux has never used this in the past to the best of my knowledge.
I am the first to push the idea, regardless how obvious it seems.
In the past it was a "WAG" or "BHAG" but nobody has ever taken it
seriously and now that Linux is finally becoming a serious OS, it needs to
grow some wisdom.

Now the short version is to perform a write-read-verify-compare.

Regards,


Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

