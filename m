Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263823AbRFDBuG>; Sun, 3 Jun 2001 21:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263827AbRFDBt4>; Sun, 3 Jun 2001 21:49:56 -0400
Received: from cogent.ecohler.net ([216.135.202.106]:29881 "EHLO
	cogent.ecohler.net") by vger.kernel.org with ESMTP
	id <S263823AbRFDBtr>; Sun, 3 Jun 2001 21:49:47 -0400
Date: Sun, 3 Jun 2001 21:49:40 -0400
From: lists@sapience.com
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac7
Message-ID: <20010603214940.A19102@sapience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E156Z88-0004O1-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 FYI:

 2 small issues:

    o make xconfig fails (works ok in ac6) : 

      cat header.tk >> ./kconfig.tk
      ./tkparse < ../arch/i386/config.in >> kconfig.tk
      drivers/net/wireless/Config.in: 5: can't handle dep_bool/dep_mbool/dep_tristate condition
      make[1]: *** [kconfig.tk] Error 1

    o soundblaster link problem (ok in ac3 - but bad in ac6 as well) :
    
      drivers/sound/sounddrivers.o: In function `es1371_probe':
      drivers/sound/sounddrivers.o(.text+0x5d6d): undefined reference to `gameport_register_port'
      drivers/sound/sounddrivers.o: In function `es1371_remove':
      drivers/sound/sounddrivers.o(.text+0x5e81): undefined reference to `gameport_unregister_port'

  Gene/
  
--
  Gene Cohler
  lists@sapience.com
