Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276162AbRJCMm1>; Wed, 3 Oct 2001 08:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276159AbRJCMmS>; Wed, 3 Oct 2001 08:42:18 -0400
Received: from janeway.cistron.net ([195.64.65.23]:12557 "EHLO
	janeway.cistron.net") by vger.kernel.org with ESMTP
	id <S276153AbRJCMmK>; Wed, 3 Oct 2001 08:42:10 -0400
Date: Wed, 3 Oct 2001 14:42:36 +0200
From: Wichert Akkerman <wichert@cistron.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-lvm@sistina.com
Subject: Re: [linux-lvm] Re: partition table read incorrectly
Message-ID: <20011003144236.A31796@cistron.nl>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, linux-lvm@sistina.com
In-Reply-To: <20011002202934.G14582@wiggy.net> <E15oUUf-0005Xw-00@the-village.bc.nu> <20011002220053.H14582@wiggy.net> <20011002150820.N8954@turbolinux.com> <20011003142633.A16089@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011003142633.A16089@cistron.nl>; from wichert@cistron.nl on Wed, Oct 03, 2001 at 02:26:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here are the first 512 bytes for the disk which the kernel gets
wrong (/dev/sdb):

000000 48 4d 01 00 00 00 00 00 00 04 00 00 00 10 00 00
000010 00 10 00 00 00 20 00 00 00 80 00 00 00 a0 00 00
000020 00 48 01 00 00 f0 01 00 00 00 41 00 47 59 75 35
000030 50 30 6a 63 58 57 45 42 74 38 64 44 74 70 51 6d
000040 31 6a 50 38 57 41 31 4e 5a 46 39 65 00 00 00 00
000050 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
*
0000a0 00 00 00 00 00 00 00 00 00 00 00 00 76 67 5f 75
0000b0 73 65 72 00 00 00 00 00 00 00 00 00 00 00 00 00
0000c0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
*
000120 00 00 00 00 00 00 00 00 00 00 00 00 63 6c 6f 75
000130 64 31 30 30 31 37 38 30 32 30 38 00 00 00 00 00
000140 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
*
0001a0 00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00
0001b0 01 00 00 00 01 00 00 00 02 00 00 00 70 90 23 02
0001c0 01 00 00 00 00 20 00 00 1b 11 00 00 80 00 00 00
0001d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
*
0001f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 55 aa

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
