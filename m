Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278107AbRJKFX0>; Thu, 11 Oct 2001 01:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278106AbRJKFXR>; Thu, 11 Oct 2001 01:23:17 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:44024 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278107AbRJKFW7>;
	Thu, 11 Oct 2001 01:22:59 -0400
Date: Thu, 11 Oct 2001 01:23:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: arvest@orphansonfire.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 loses sda9
In-Reply-To: <01101100201700.04473@lithium>
Message-ID: <Pine.GSO.4.21.0110110121270.21168-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Oct 2001 arvest@orphansonfire.com wrote:

>   I can get the system booted enough to work on (and totaly up) with this 
> partition failing.  I dont know what more information from fdisk I can give 
> you, sda9 is there with .10, and gone with .11  It even allowed me to add a 
> new partition (i didnt save)  I tried sfdisk but it gave me these errors.

Sigh... OK, dmesg|grep sda on both kernels + fdisk -l /dev/sda (also on
both).

