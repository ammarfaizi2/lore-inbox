Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282870AbRLBNIL>; Sun, 2 Dec 2001 08:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282874AbRLBNHy>; Sun, 2 Dec 2001 08:07:54 -0500
Received: from mail006.mail.bellsouth.net ([205.152.58.26]:14493 "EHLO
	imf06bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S282870AbRLBNHk>; Sun, 2 Dec 2001 08:07:40 -0500
Message-ID: <3C0A2797.A232CE7B@mandrakesoft.com>
Date: Sun, 02 Dec 2001 08:07:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel list <linux-kernel@vger.kernel.org>
CC: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: PATCH 2.4.17.2: CONFIG_FINAL, make kernel smaller
In-Reply-To: <3C0A1105.18B76D64@mandrakesoft.com> <25560.1007294074@ocs3.intra.ocs.com.au> <20011202133314.B717@nightmaster.csn.tu-chemnitz.de> <3C0A2609.AB42C366@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> The conversion of linux/kernel was surprising...  I only changed two
> 'int' variables to KSTATIC.  That implies to me that the majority of the
> space savings might simply come from the better packing created when
> compiling all the files into a single .o.

Note that this implies we can get some code size savings without marking
all the functions KSTATIC... simply compiling them together gets a gain,
although not one as big as is possible with all applicable functions
marked.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

