Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSFAV5m>; Sat, 1 Jun 2002 17:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317074AbSFAV5l>; Sat, 1 Jun 2002 17:57:41 -0400
Received: from pcp809261pcs.nrockv01.md.comcast.net ([68.49.81.201]:28546 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S317073AbSFAV5l>;
	Sat, 1 Jun 2002 17:57:41 -0400
Date: Sat, 1 Jun 2002 17:57:42 -0400
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel (2.4.19-pre8) hang
Message-ID: <20020601175742.B1409@zalem.puupuu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1022527454.1606.22.camel@linux> <1022534650.11859.316.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 10:24:10PM +0100, Alan Cox wrote:
> On Mon, 2002-05-27 at 20:24, Frederik Nosi wrote:
> > May 27 18:28:13 linux kernel: EXT3-fs error (device ide0(3,7)):
> > ext3_free_blocks: bit already cleared for block 215665
> > 
> > I suspect at my hd too but for being sure... Please CC me because I'm
> > not subscribed to the list and excuse me for my bad english and the long
> > mail.
> 
> What mode is your hard disk reported to be in. If it is using UDMA then
> its very unlikely to be the disk itself. We also should now have all the
> needed workarounds for VIA chipset bugs.

It may be interested to note that the kt266 was unstable with a kernel
as recent as pre8-ac9.  It works correctly with pre9-ac3 (I haven't
tested straight pre9, one reiserfsck --rebuild-tree is enough).

  OG.

