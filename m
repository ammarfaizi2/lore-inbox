Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285273AbSAPRct>; Wed, 16 Jan 2002 12:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285022AbSAPRaz>; Wed, 16 Jan 2002 12:30:55 -0500
Received: from ns.suse.de ([213.95.15.193]:41739 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285023AbSAPRaW>;
	Wed, 16 Jan 2002 12:30:22 -0500
Date: Wed, 16 Jan 2002 18:30:20 +0100
From: Dave Jones <davej@suse.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Richard Henderson <rth@twiddle.net>,
        Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
Message-ID: <20020116183020.A12977@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Richard Henderson <rth@twiddle.net>,
	Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020111141850.A9873@twiddle.net> <E16PAld-0000c9-00@the-village.bc.nu> <20020116151852.B31993@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020116151852.B31993@kushida.apsleyroad.org>; from lk@tantalophile.demon.co.uk on Wed, Jan 16, 2002 at 03:18:52PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 03:18:52PM +0000, Jamie Lokier wrote:
 > > > What's the point of optimizing an IF to a cmov if I have
 > > > to insert another IF to see if I can use cmov?
 > > I've always wondered. Intel made the instruction optional yet there isnt
 > > an obvious way to do runtime fixups on it
 > Yes there is -- emulation! :-)

 Too much overhead to be of practical use..

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
