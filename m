Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSE0Qed>; Mon, 27 May 2002 12:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSE0Qec>; Mon, 27 May 2002 12:34:32 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:60654 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316683AbSE0Qeb>; Mon, 27 May 2002 12:34:31 -0400
Subject: Re: VM oops in RH7.3 2.4.18-3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt Bernstein <matt@theBachChoir.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205271518270.5065-100000@nick.dcs.qmul.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 18:36:26 +0100
Message-Id: <1022520986.1126.300.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 15:26, Matt Bernstein wrote:
> This is a dual Athlon, 1 gig registered ECC DDR RAM, will try 2.4.18-4 but
> it doesn't look ext3-related (the only big local filesystem is reiserfs
> over s/w raid0).
> 
> I do suspect the hardware on this machine. If someone could tell me "that
> looks like a bad x", I'd be very grateful. More details on request :-/

It could be bad RAM but there is nothing in the dump that stands out and
says it is. memtest86 is stil the best test of that. If you are running
dual Athlon also check your ventilation and PSU - you need a 400W PSU
but not all 400W PSUs provide enough power on the specific lines.

Alan

