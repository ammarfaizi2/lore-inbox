Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261400AbRE2S5e>; Tue, 29 May 2001 14:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbRE2S5Y>; Tue, 29 May 2001 14:57:24 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:35083 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S261400AbRE2S5N>;
	Tue, 29 May 2001 14:57:13 -0400
Date: Tue, 29 May 2001 14:59:40 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Remaining undocumented Configure.help symbols
Message-ID: <20010529145940.A11498@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the help of a number of contributors, Steven Cole and I have
managed to cut the list of undocumented configuration symbols from the
previous 55 to 10.  The three *_NET_SCH_* symbols that didn't appear
in the previous listing have popped up because my cross-referencer was
fooled by some old comments in Configure.help.

Networking:

CONFIG_NET_CLS_POLICE
CONFIG_NET_CLS_TCINDEX
CONFIG_NET_SCH_INGRESS

ARM port:

CONFIG_SA1100_SHERMAN

PPC port:

CONFIG_EST8260
CONFIG_BLK_DEV_MPC8xx_IDE
CONFIG_IRQ_ALL_CPUS
CONFIG_USE_MDIO

CRIS port:

CONFIG_ETRAX_FLASH_BUSWIDTH
CONFIG_ETRAX_I2C_USES_PB_NOT_PB_I2C

As before, if you know enough about any of these configuration options to
write a help entry, please send it to me.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

You need only reflect that one of the best ways to get yourself 
a reputation as a dangerous citizen these days is to go about 
repeating the very phrases which our founding fathers used in the 
great struggle for independence.
	-- Attributed to Charles Austin Beard (1874-1948)
