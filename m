Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287615AbSANRQD>; Mon, 14 Jan 2002 12:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287743AbSANRPx>; Mon, 14 Jan 2002 12:15:53 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:63483 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S287658AbSANRPm>;
	Mon, 14 Jan 2002 12:15:42 -0500
Date: Mon, 14 Jan 2002 10:15:29 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- third draft
Message-ID: <20020114101529.K26688@lynx.adilger.int>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1010958148.8691.0.camel@voyager> <a1t270$nq0$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <a1t270$nq0$1@cesium.transmeta.com>; from hpa@zytor.com on Sun, Jan 13, 2002 at 02:37:20PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 13, 2002  14:37 -0800, H. Peter Anvin wrote:
> > >    initramfs  :=3D ("\0" | cpio_archive | cpio_gzip_archive)*
> > >
> > >    cpio_gzip_archive :=3D GZIP(cpio_archive)
> 
> Allow GZIP(cpio_file* + cpio_trailer), which is in fact a very common
> configuration.

So, just to clarify, if you have multiple cpio archives concatenated,
they are gzipped separately before concatenation, or gzipped after
concatenation?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

