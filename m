Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143399AbREKVGv>; Fri, 11 May 2001 17:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143400AbREKVGm>; Fri, 11 May 2001 17:06:42 -0400
Received: from oss.sgi.com ([216.32.174.190]:7437 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id <S143399AbREKVGf>;
	Fri, 11 May 2001 17:06:35 -0400
Date: Fri, 11 May 2001 01:02:53 -0300
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: Athlon possible fixes
Message-ID: <20010511010253.A1257@bacchus.dhis.org>
In-Reply-To: <20010506142346.C31269@metastasis.f00f.org> <E14wO16-00023N-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14wO16-00023N-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, May 06, 2001 at 01:51:59PM +0100
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2001 at 01:51:59PM +0100, Alan Cox wrote:

> > There really needs to be a hardware fix... this doesn't stop some
> > application having it's owne optimised code from breaking on some
> > hardware (think games and similation software perhaps).
> 
> prefetch is virtually addresses. An application would need access to /dev/mem
> or similar. So the only folks I think it might actually bite are the Xserver
> people.

Prefetch bugs in hardware have biten Linux/68k as early as '94; a GVP SCSI
HBA on the Amiga may touch areas beyond the last valid RAM address when
doing DMA to the last page.  Being a burned child from that time Linux/MIPS
didn't use the last RAM page just to be on the safe side.

  Ralf
