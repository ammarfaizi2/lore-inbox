Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266876AbSK1XxH>; Thu, 28 Nov 2002 18:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266897AbSK1XxH>; Thu, 28 Nov 2002 18:53:07 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:8685 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266876AbSK1XxF>;
	Thu, 28 Nov 2002 18:53:05 -0500
Date: Thu, 28 Nov 2002 23:58:15 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Matthieu Fecteau <matthieufecteau@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM : AGP don't work for SiS 645DX chipset (Asus P4S533)
Message-ID: <20021128235815.GA10928@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Matthieu Fecteau <matthieufecteau@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20021128230644.97656.qmail@web40506.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021128230644.97656.qmail@web40506.mail.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2002 at 03:06:44PM -0800, Matthieu Fecteau wrote:
 > Hello!
 > 
 > kernel (redhat) : 2.4.18-14
 > 
 > I don't know why, but the AGP do not work on this
 > chipset and the hard drive and CD-Roms do not seem to
 > be very fast, like it could.  Is it a problem with my
 > machine or is it that the kernel is not currently
 > supporting it.  Will it be supported one day by the
 > kernel if it's the problem ?

Try modprobe agpgart try_unsupported=1
If that works, let me know the output of dmesg.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
