Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289970AbSAPP0P>; Wed, 16 Jan 2002 10:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289971AbSAPP0E>; Wed, 16 Jan 2002 10:26:04 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:63706 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S289970AbSAPPZu>; Wed, 16 Jan 2002 10:25:50 -0500
Date: Wed, 16 Jan 2002 15:18:52 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Henderson <rth@twiddle.net>,
        Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
Message-ID: <20020116151852.B31993@kushida.apsleyroad.org>
In-Reply-To: <20020111141850.A9873@twiddle.net> <E16PAld-0000c9-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16PAld-0000c9-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 11, 2002 at 11:07:21PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > What's the point of optimizing an IF to a cmov if I have
> > to insert another IF to see if I can use cmov?
> 
> I've always wondered. Intel made the instruction optional yet there isnt
> an obvious way to do runtime fixups on it

Yes there is -- emulation! :-)

-- Jamie
