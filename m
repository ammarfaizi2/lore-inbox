Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293542AbSBZU7G>; Tue, 26 Feb 2002 15:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293600AbSBZU64>; Tue, 26 Feb 2002 15:58:56 -0500
Received: from petkele.almamedia.fi ([194.215.205.158]:62875 "HELO
	petkele.almamedia.fi") by vger.kernel.org with SMTP
	id <S293542AbSBZU6g>; Tue, 26 Feb 2002 15:58:36 -0500
Message-ID: <3C7BF6F1.303DC5D0@pp.inet.fi>
Date: Tue, 26 Feb 2002 22:58:25 +0200
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mailerror@hushmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: loop under 2.2.20 - relative block support?
In-Reply-To: <200202251943.g1PJhh231456@mailserver4.hushmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mailerror@hushmail.com wrote:
> On Mon, 25 Feb 2002 20:41:25 +0200, Jari Ruusu <jari.ruusu@pp.inet.fi> wrote:
> >If you can move original (unmodified) loop file to same block size, same
> >kernel version, then yes. If you mounted it rw, then your "time bomb"
> >exploded on your face.
> >
> 
> Okay, my files are fine then, since the files were burned on cd right after I
> created them.
> 
> Is this still a problem with the 2.4 loop device? In your patch for 2.4.16
> I noticed that the IV calculation is independent from the underlying block
> size. That alone would be enough to make me switch over from 2.2 ;-)

Recent versions of cryptoapi do 512 byte IV as do all versions of loop-AES
(maintained by me, http://loop-aes.sourceforge.net/). If you want to keep
using 2.2 kernels or want to use distro vendor kernels, loop-AES is better
choice as it works with all kernels and has more up to date loop fixes than
cryptoapi.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
