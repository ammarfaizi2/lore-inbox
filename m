Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284168AbRLARs0>; Sat, 1 Dec 2001 12:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284169AbRLARsQ>; Sat, 1 Dec 2001 12:48:16 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:60315
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S284168AbRLARsN>; Sat, 1 Dec 2001 12:48:13 -0500
Date: Sat, 1 Dec 2001 10:48:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Missing Configure,help entries need filling in
Message-ID: <20011201104813.E7819@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011201122608.A9983@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011201122608.A9983@thyrsus.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 12:26:08PM -0500, Eric S. Raymond wrote:

> We're down to 120 missing help entries.  If you can fill some of these
> in, please send me a patch for Configure.help.
[snip]
> I2C_ALGO8XX
> I2C_PPC405_ADAP
> I2C_PPC405_ALGO
> I2C_RPXLITE

Please ignore these for now as the code isn't in the tree either.  For
the time being it would be more correct to comment out the config
questions.

> UCODE_PATCH

Once again:
Motorola releases microcode updates for their 8xx CPM modules.  The
microcode update file has updates for IIC, SMC and USB.  Currently only
the USB update is available by default, if the MPC8xx USB option is
enabled.  If in doubt, say 'N' here.

And yes, the USB driver isn't in the tree yet either.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
