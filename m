Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310979AbSCTBeE>; Tue, 19 Mar 2002 20:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310989AbSCTBdy>; Tue, 19 Mar 2002 20:33:54 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:1222 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S310979AbSCTBdq>; Tue, 19 Mar 2002 20:33:46 -0500
Date: Tue, 19 Mar 2002 19:33:33 -0600
From: Ken Brownfield <ken@irridia.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: m.knoblauch@TeraPort.de,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem Corruption (ext2) on Tyan S2462, 2xAMD1900MP, 2.4.17SMP (RH7.2)
Message-ID: <20020319193333.C15811@asooo.flowerfire.com>
In-Reply-To: <20020319190211.B15811@asooo.flowerfire.com> <E16nUx8-0000w4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 01:31:46AM +0000, Alan Cox wrote:
| I can confirm problems with serverworks OSB4 and UDMA. With UDMA and
[...]

Thanks.  This also points out that I mistakenly said DMA rather than
UDMA.  Someone else mentioned to me that MDMA worked for them as well.
It would have been "fine" if the serverworks driver didn't leave UDMA on
when it's off by default in the CONFIG.  At least then you would be
making the choice to specifically enable UDMA at your own risk...

| This was observed across a large number of boxes in a rendering farm so its
| not a one off flawed box, and across two board vendors. I reported it to
| serverworks who were interested but couldnt reproduce it in their lab.

Quite possible.  I'm only seeing this on ServerWorks mobos with IDE as
primary (vs SCSI).  I heard third-hand via a FreeBSD post that it's an
OSB4 issue effecting them as well.  Are Seagates a requirement for the
issues?

As to whether they can reproduce it... I'm not holding my breath for
them to try.

Thanks much for the info,
-- 
Ken.
ken@irridia.com
