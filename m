Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263536AbREYFTV>; Fri, 25 May 2001 01:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263537AbREYFTM>; Fri, 25 May 2001 01:19:12 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:55566 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S263536AbREYFTA>;
	Fri, 25 May 2001 01:19:00 -0400
Date: Fri, 25 May 2001 01:22:00 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Configure.help entries wanted
Message-ID: <20010525012200.A5259@thyrsus.com>
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

Over the last few week, Steven Cole and I have been working hard on filling 
in the missing entries in Configure.help.  When I accepted the maintainer's 
baton from Axel Boldt, there were 537 of these.  There are now 55.  Yes,
we collected around 50 entries and outright wrote close to 450 others.

That's the good news.  The bad news is that the 55 left are the ones we could 
not document by reading the code and doing Web searches to find context.
All but two are buried in deep, obscure corners of the port trees.

If we take the open-source idea seriously, we're trying to create a
kernel that can be tinkered with by anyone with a bright idea.
Therefore we should have *every* configuration symbol documented.  

Please help.  If you understand what one of these symbols is doing, mail 
me and tell me.  Your English doesn't have to be perfectly polished, I'll
take care of that.  The important thing is that your explanation should
provide *motivation* -- not just what the option does, but why somebody 
building a kernel might want it on.

Here's an example of a poor explanation:

CONFIG_GONKULATOR
   Say Y here to support adaptive gonkulation using the Randomatics 5523
   board.

Here's an example of a good explanation:

CONFIG_GONKULATOR
   Say Y here to enable adaptive gonkulation using the Randomatics 5523
   board.  With this feature you'll be able to cross-wire your frobozz ports
   to a nonce generator for significantly faster foo-counter spin.

Amaze your friends and confound your enemies with your hackerly erudition --
contribute a Configure.help entry today!

---------------------------------------------------------------------------
Mainline:

CONFIG_NET_SCH_ATM

Multiple ports:

CONFIG_SUN_KEYBOARD

ARM port:

CONFIG_ARCH_FTVPCI
CONFIG_ARCH_NEXUSPCI
CONFIG_ARCH_P720T
CONFIG_CPU_ARM920_CPU_IDLE
CONFIG_CPU_ARM920_D_CACHE_ON
CONFIG_CPU_ARM920_I_CACHE_ON
CONFIG_DEBUG_CLPS711X_UART2
CONFIG_SA1100_SHERMAN

PPC port:

CONFIG_EST8260
CONFIG_BLK_DEV_MPC8xx_IDE
CONFIG_IRQ_ALL_CPUS
CONFIG_USE_MDIO

S390 port:

CONFIG_CHANDEV
CONFIG_CTC
CONFIG_DASD_DIAG
CONFIG_BLK_DEV_XPRAM
CONFIG_FAST_IRQ
CONFIG_IUCV
CONFIG_S390_SUPPORT
CONFIG_S390_TAPE
CONFIG_S390_TAPE_3480
CONFIG_S390_TAPE_3490
CONFIG_S390_TAPE_BLOCK
CONFIG_S390_TAPE_CHAR

SuperH port:

CONFIG_SH_SCI
CONFIG_SH_STANDARD_BIOS
CONFIG_DEBUG_KERNEL_WITH_GDB_STUB

IA64 port:

CONFIG_DISABLE_VHPT
CONFIG_MCKINLEY_A0_SPECIFIC
CONFIG_MCKINLEY_ASTEP_SPECIFIC
CONFIG_IA64_DEBUG_CMPXCHG
CONFIG_IA64_DEBUG_IRQ
CONFIG_IA64_EARLY_PRINTK
CONFIG_IA64_PRINT_HAZARDS

CRIS port:

CONFIG_ETRAX_FLASH_BUSWIDTH
CONFIG_ETRAX_I2C_USES_PB_NOT_PB_I2C
CONFIG_ETRAX_RS485_ON_PA_BIT
CONFIG_ETRAX_SDRAM
CONFIG_ETRAX_SER0_CD_ON_PB_BIT
CONFIG_ETRAX_SER0_DSR_ON_PB_BIT
CONFIG_ETRAX_SER0_DTR_ON_PB_BIT
CONFIG_ETRAX_SER0_RI_ON_PB_BIT
CONFIG_ETRAX_SER1_CD_ON_PB_BIT
CONFIG_ETRAX_SER1_DSR_ON_PB_BIT
CONFIG_ETRAX_SER1_DTR_ON_PB_BIT
CONFIG_ETRAX_SER1_RI_ON_PB_BIT
CONFIG_ETRAX_SER2_CD_ON_PA_BIT
CONFIG_ETRAX_SER2_DSR_ON_PA_BIT
CONFIG_ETRAX_SER2_DTR_ON_PA_BIT
CONFIG_ETRAX_SER2_RI_ON_PA_BIT
CONFIG_JULIETTE

PA-RISC port:

CONFIG_IODC_CONSOLE
CONFIG_IOMMU_CCIO
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Nearly all men can stand adversity, but if you want to test a man's character,
give him power.
	-- Abraham Lincoln
