Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSIEBKW>; Wed, 4 Sep 2002 21:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSIEBKW>; Wed, 4 Sep 2002 21:10:22 -0400
Received: from [208.34.239.122] ([208.34.239.122]:18816 "EHLO
	babylon5.babcom.com") by vger.kernel.org with ESMTP
	id <S316580AbSIEBKW>; Wed, 4 Sep 2002 21:10:22 -0400
Date: Wed, 4 Sep 2002 21:16:23 -0400
From: Phil Stracchino <alaric@babcom.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:  Kernel 2.4.19 does not export _mmx_memcpy when compiled with gcc-3.2 and Athlon optimizations
Message-ID: <20020905011623.GB921@babylon5.babcom.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
References: <20020904181952.GA1158@babylon5.babcom.com> <1031182512.3017.139.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031182512.3017.139.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: 2105 C6FC 945D 2A7A 0738  9BB8 D037 CE8E EFA1 3249
X-PGP-Key-FTP-URL: ftp://ftp.babcom.com/pub/pgpkeys/alaric.asc
X-PGP-Key-HTTP-URL: http://www.babcom.com/alaric/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 12:35:12AM +0100, Alan Cox wrote:
> On Wed, 2002-09-04 at 19:19, Phil Stracchino wrote:
> > PROBLEM SUMMARY:
> > Kernel 2.4.19 apparently fails to export _mmx_memcpy when compiled with
> > gcc-3.2 and Athlon optimizations
> 
> You need to save your .config make distclean, restore it make oldconfig
> dep and build the kernel. Its a known limitation in the CML1 config
> tools


Aha, so it's a known config problem, not bizarre psychic terrorism on
the part of the source code.  Thank you for saving my sanity.  :)  I'll
give that procedure a shot.


-- 
  *********  Fight Back!  It may not be just YOUR life at risk.  *********
  phil stracchino   ::   alaric@babcom.com   ::   halmayne@sourceforge.net
    unix ronin     ::::   renaissance man   ::::   mystic zen biker geek
     2000 CBR929RR, 1991 VFR750F3 (foully murdered), 1986 VF500F (sold)
       Linux Now! ...because friends don't let friends use Microsoft.
