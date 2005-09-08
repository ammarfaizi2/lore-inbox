Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbVIHPZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbVIHPZs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbVIHPZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:25:47 -0400
Received: from [64.162.99.240] ([64.162.99.240]:45224 "EHLO
	spamtest2.viacore.net") by vger.kernel.org with ESMTP
	id S932685AbVIHPZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:25:46 -0400
Message-ID: <432057D6.3010208@spamtest.viacore.net>
Date: Thu, 08 Sep 2005 08:25:10 -0700
From: Joe Bob Spamtest <joebob@spamtest.viacore.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: abonilla@linuxwireless.org
CC: netdev@vger.kernel.org, ieee80211-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Git broken for IPW2200
References: <1126143695.5402.11.camel@localhost.localdomain>
In-Reply-To: <1126143695.5402.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IPW2200 requires a different ieee80211 stack, this can be had at 
ieee80211.sourceforge.net



Alejandro Bonilla Beeche wrote:
> Hi,
> 
> 	Where does one report this? I was building Linus Git tree as per I
> updated it at 09/07/2005 7:00PM PDT and got this while compiling.
> 
> Where do I report this?
> 
> Debian unstable updated at same time.
> 
> it looks like ipw2200 is thinking that ieee80211 is not compiled in, but
> I did select it as a module?
> 
> drivers/net/wireless/ipw2200.c:6676: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:6677: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:6679: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:6679: error: 'WLAN_AUTH_SHARED_KEY'
> undeclared (first use in this function)
> drivers/net/wireless/ipw2200.c:6686: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:6686: error: 'SEC_ENABLED' undeclared
> (first use in this function)
> drivers/net/wireless/ipw2200.c:6687: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:6689: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:6691: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:6697: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:6697: error: 'SEC_LEVEL' undeclared
> (first use in this function)
> drivers/net/wireless/ipw2200.c:6698: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:6699: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c: In function 'init_supported_rates':
> drivers/net/wireless/ipw2200.c:6727: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:6728: error: 'IEEE80211_52GHZ_BAND'
> undeclared (first use in this function)
> drivers/net/wireless/ipw2200.c:6731: error: 'IEEE80211_CCK_MODULATION'
> undeclared (first use in this function)
> drivers/net/wireless/ipw2200.c:6732: error:
> 'IEEE80211_OFDM_DEFAULT_RATES_MASK' undeclared (first use in this
> function)
> drivers/net/wireless/ipw2200.c:6739: error:
> 'IEEE80211_CCK_DEFAULT_RATES_MASK' undeclared (first use in this
> function)
> drivers/net/wireless/ipw2200.c:6740: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:6740: error: 'IEEE80211_OFDM_MODULATION'
> undeclared (first use in this function)
> drivers/net/wireless/ipw2200.c: In function 'ipw_net_init':
> drivers/net/wireless/ipw2200.c:6887: warning: initialization makes
> pointer from integer without a cast
> drivers/net/wireless/ipw2200.c: In function 'ipw_pci_probe':
> drivers/net/wireless/ipw2200.c:6970: warning: implicit declaration of
> function 'alloc_ieee80211'
> drivers/net/wireless/ipw2200.c:6970: warning: assignment makes pointer
> from integer without a cast
> drivers/net/wireless/ipw2200.c:6976: warning: assignment makes pointer
> from integer without a cast
> drivers/net/wireless/ipw2200.c:7060: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:7069: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:7078: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:7079: error: 'IEEE80211_52GHZ_BAND'
> undeclared (first use in this function)
> drivers/net/wireless/ipw2200.c:7079: error: 'IEEE80211_24GHZ_BAND'
> undeclared (first use in this function)
> drivers/net/wireless/ipw2200.c:7080: error: 'IEEE80211_OFDM_MODULATION'
> undeclared (first use in this function)
> drivers/net/wireless/ipw2200.c:7081: error: 'IEEE80211_CCK_MODULATION'
> undeclared (first use in this function)
> drivers/net/wireless/ipw2200.c:7083: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:7083: error: 'IEEE_A' undeclared (first
> use in this function)
> drivers/net/wireless/ipw2200.c:7083: error: 'IEEE_G' undeclared (first
> use in this function)
> drivers/net/wireless/ipw2200.c:7083: error: 'IEEE_B' undeclared (first
> use in this function)
> drivers/net/wireless/ipw2200.c:7094: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:7099: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:7102: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:7103: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:7105: error:
> 'IEEE80211_DEFAULT_RATES_MASK' undeclared (first use in this function)
> drivers/net/wireless/ipw2200.c:7126: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:7127: error: dereferencing pointer to
> incomplete type
> drivers/net/wireless/ipw2200.c:7172: warning: implicit declaration of
> function 'free_ieee80211'
> make[4]: *** [drivers/net/wireless/ipw2200.o] Error 1
> make[3]: *** [drivers/net/wireless] Error 2
> make[2]: *** [drivers/net] Error 2
> make[1]: *** [drivers] Error 2
> make[1]: Leaving directory `/root/linux-2.6'
> make: *** [stamp-build] Error 2
> debian:~/linux-2.6#
> 
> .Alejandro
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> ------------------------------------------------------------------------
> 
> -- 
> / This message has been classified as *non-spam*.
> Mark this message as spam. 
> <mailto:spam@spamtest.viacore.net?Subject=09072005183846-20792&body=Click 
> the send button to mark this message as spam.>
> 
> Thank you for using the crm114 Spam Control System. /
