Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278927AbRKANfI>; Thu, 1 Nov 2001 08:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278924AbRKANet>; Thu, 1 Nov 2001 08:34:49 -0500
Received: from tahallah.demon.co.uk ([158.152.175.193]:35824 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S278922AbRKANej>; Thu, 1 Nov 2001 08:34:39 -0500
Date: Thu, 1 Nov 2001 13:19:49 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Paul Mackerras <paulus@samba.org>
cc: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [sparc] Weird ioctl() bug in 2.2.19 (fwd)
In-Reply-To: <15328.50963.299395.630022@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0111011318420.1468-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, Paul Mackerras wrote:

> > Anyway, I can fix it now by adding the appropriate AFMT_S16_BE statement
> > guarded by a #ifdef but this sucks. Thanks to Peter Jones who spotted this
> > one.
>
> Why can't you just use AFMT_S16_NE on all platforms?  That is supposed
> to be equal to AFMT_S16_BE on big-endian platforms and to AFMT_S16_LE
> on little-endian platforms.  NE == native endian.

Ah, is that what it does. OK, I'll carefully suggest to the authors of ESD
(preferably with a blunt trauma instrument) using AFMT_S16_NE. Thanks.

-- 
Come the revolution, humourless gits'll be first up against the wall.

http://www.tahallah.demon.co.uk

