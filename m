Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319117AbSIDKSI>; Wed, 4 Sep 2002 06:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319118AbSIDKSI>; Wed, 4 Sep 2002 06:18:08 -0400
Received: from users.linvision.com ([62.58.92.114]:55427 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S319117AbSIDKSG>; Wed, 4 Sep 2002 06:18:06 -0400
Date: Wed, 4 Sep 2002 12:21:56 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mike Isely <isely@pobox.com>, mbs <mbs@mc.com>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4-ac1 trashed my system
Message-ID: <20020904122156.A20614@bitwizard.nl>
References: <Pine.LNX.4.44.0209030917040.17540-100000@grace.speakeasy.net> <1031068858.21409.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031068858.21409.13.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 05:00:58PM +0100, Alan Cox wrote:
> > Unfortunately you've said you are using a 40GB drive and something other
> > than a Promise controller so your situation may be a different problem.
> 
> The 40Gb drives may well be trying to pick LBA48, but LBA48 works on the
> Intel hardware

The maxtor drives

	XxYYYyZ

where 
	X is a number
	x is a letter
	YYY is the capacity (040 for a 40G)
	y is a letter
	Z is a number. 

When Z = 2, the disk is single platter, and COULD have been 4 times as
large by adding three more platters. That adds up to 160G so the 

Xy040z2 drives will certainly do LBA48. 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currenly in such an       * 
* excursion: The stable situation does not include humans. ***************
