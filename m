Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281281AbRKMHoG>; Tue, 13 Nov 2001 02:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281416AbRKMHn5>; Tue, 13 Nov 2001 02:43:57 -0500
Received: from ns.caldera.de ([212.34.180.1]:52707 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S281281AbRKMHnh>;
	Tue, 13 Nov 2001 02:43:37 -0500
Date: Tue, 13 Nov 2001 08:43:29 +0100
From: Christoph Hellwig <hch@caldera.de>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
Message-ID: <20011113084329.A14963@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	"J . A . Magallon" <jamagallon@able.es>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20011113004846.G1531@werewolf.able.es> <200111130014.fAD0Eel15650@ns.caldera.de> <20011113014248.A1487@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011113014248.A1487@werewolf.able.es>; from jamagallon@able.es on Tue, Nov 13, 2001 at 01:42:48AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 01:42:48AM +0100, J . A . Magallon wrote:
> This should also stay, so ?
> 
> -   if [ "$CONFIG_MIPS_ITE8172" = "y" ]; then
> -      dep_tristate 'ITE I2C Algorithm' CONFIG_ITE_I2C_ALGO $CONFIG_I2C
> -      if [ "$CONFIG_ITE_I2C_ALGO" != "n" ]; then
> -         dep_tristate '  ITE I2C Adapter' CONFIG_ITE_I2C_ADAP $CONFIG_ITE_I2C_ALGO
> -      fi
> -   fi

*nod* - maybe someone should merge that driver into CVS..

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
