Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWBLKtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWBLKtZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 05:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWBLKtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 05:49:24 -0500
Received: from mail.charite.de ([160.45.207.131]:53213 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1750829AbWBLKtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 05:49:24 -0500
Date: Sun, 12 Feb 2006 11:49:20 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc2-git8: ieee80211 does not compile
Message-ID: <20060212104920.GU2690@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060210123817.GQ6668@charite.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060210123817.GQ6668@charite.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:
> I get:
>   ...
>   LD [M]  sound/pci/ac97/snd-ac97-codec.o
>   CC [M]  net/ieee80211/ieee80211_module.o
>   CC [M]  net/ieee80211/ieee80211_tx.o
> net/ieee80211/ieee80211_tx.c: In function ieee80211_xmit':
> net/ieee80211/ieee80211_tx.c:473: error: too few arguments to function
> make[3]: *** [net/ieee80211/ieee80211_tx.o] Error 1
> make[2]: *** [net/ieee80211] Error 2
> make[1]: *** [net] Error 2
> make[1]: Leaving directory /usr/src/linux-2.6.16-rc2-git8'
> make: *** [debian/stamp-build-kernel] Error 2

Same with linux-2.6.16-rc2-git11:
  LD [M]  sound/pci/ac97/snd-ac97-bus.o
  LD [M]  sound/pci/ac97/snd-ac97-codec.o
  CC [M]  net/ieee80211/ieee80211_module.o
  CC [M]  net/ieee80211/ieee80211_tx.o
net/ieee80211/ieee80211_tx.c: In function ieee80211_xmit':
net/ieee80211/ieee80211_tx.c:473: error: too few arguments to function
make[3]: *** [net/ieee	80211/ieee80211_tx.o] Error 1
make[2]: *** [net/ieee80211] Error 2
make[1]: *** [net] Error 2
make[1]: Leaving directory /usr/src/linux-2.6.16-rc2-git11'
make: *** [debian/stamp-build-kernel] Error 2
	
-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
