Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273265AbRINCju>; Thu, 13 Sep 2001 22:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273266AbRINCjj>; Thu, 13 Sep 2001 22:39:39 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:47493
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S273265AbRINCjb>; Thu, 13 Sep 2001 22:39:31 -0400
Date: Thu, 13 Sep 2001 19:39:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: jgarzik@mandrakesoft.com, becker@scyld.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endian-ness bugs in yellowfin.c
Message-ID: <20010913193937.O21906@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20010913195141.B799@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010913195141.B799@boardwalk>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2001 at 07:51:41PM -0600, Val Henson wrote:

> diff -Nru a/drivers/net/Config.in b/drivers/net/Config.in
> --- a/drivers/net/Config.in	Thu Sep 13 19:20:29 2001
> +++ b/drivers/net/Config.in	Thu Sep 13 19:20:29 2001
> @@ -39,7 +39,7 @@
>        fi
>        dep_tristate '  BMAC (G3 ethernet) support' CONFIG_BMAC $CONFIG_ALL_PPC
>        dep_tristate '  GMAC (G4/iBook ethernet) support' CONFIG_GMAC $CONFIG_ALL_PPC
> -      tristate '  Symbios 53c885 (Synergy ethernet) support' CONFIG_NCR885E
> +      tristate '  Symbios 53c885 (Synergy ethernet) support' CONFIG_YELLOWFIN
>        tristate '  National DP83902AV (Oak ethernet) support' CONFIG_OAKNET
>        dep_bool '  PowerPC 405 on-chip ethernet' CONFIG_PPC405_ENET $CONFIG_405GP
>        if [ "$CONFIG_PPC405_ENET" = "y" ]; then

Since you're killing this, why not just remove this question entirely?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
