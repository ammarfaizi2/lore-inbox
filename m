Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281158AbRKTQQf>; Tue, 20 Nov 2001 11:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281159AbRKTQQZ>; Tue, 20 Nov 2001 11:16:25 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:61590
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S281158AbRKTQQH>; Tue, 20 Nov 2001 11:16:07 -0500
Date: Tue, 20 Nov 2001 09:16:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help missing entries list
Message-ID: <20011120091607.C10819@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011120095018.A25289@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011120095018.A25289@thyrsus.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 09:50:18AM -0500, Eric S. Raymond wrote:

> I2C_ALGO8XX
> I2C_PPC405_ADAP
> I2C_PPC405_ALGO
> I2C_RPXLITE

Ignore these for now.  The code isn't in the tree yet anyhow.  I'll send
in help entries when I send in the code too.

> UCODE_PATCH

Motorola releases microcode updates for their 8xx CPM modules.  The
microcode update file has updates for IIC, SMC and USB.  Currently only
the USB update is available by default, if the MPC8xx USB option is
enabled.  If in doubt, say 'N' here.

And yes, the USB driver isn't in the tree yet either.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
