Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287293AbSAPTMq>; Wed, 16 Jan 2002 14:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287279AbSAPTMd>; Wed, 16 Jan 2002 14:12:33 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:25354 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S287297AbSAPTLu>; Wed, 16 Jan 2002 14:11:50 -0500
Date: Wed, 16 Jan 2002 20:11:38 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: prodyut hazarika <prodyut_hazarika@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interpreting ELF file on a ramdisk (block device)
Message-ID: <20020116191138.GI10175@arthur.ubicom.tudelft.nl>
In-Reply-To: <20020116124008.50778.qmail@web13001.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020116124008.50778.qmail@web13001.mail.yahoo.com>
User-Agent: Mutt/1.3.25i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 04:40:08AM -0800, prodyut hazarika wrote:
> I get an ELF file on a ramdisk using TFTP. I want to
> interpret the ELF file in the ramdisk, and load it
> into memory (SDRAM) using the ramdisk as a block
> device, but without using any file system.

If you have the ELF file in a ramdisk, it's already in memory.

> Is this possible? Any pointers will be greatly
> appreciated.

No, a linux kernel can't work without a filesystem.

> PS: Currently I use CRAMFS to get the ELF file into
> ramdisk. Then I load the ELF file into memory using
> CRAMFS. I want to get rid of the CRAMFS on top of ELF.

Why not use the cramfs as your rootfs?


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
