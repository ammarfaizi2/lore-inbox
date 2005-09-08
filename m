Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbVIHBl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbVIHBl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVIHBl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:41:29 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:20694
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932552AbVIHBl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:41:28 -0400
Subject: Git broken for IPW2200
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Reply-To: abonilla@linuxwireless.org
To: netdev@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Cc: ieee80211-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 19:41:35 -0600
Message-Id: <1126143695.5402.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Where does one report this? I was building Linus Git tree as per I
updated it at 09/07/2005 7:00PM PDT and got this while compiling.

Where do I report this?

Debian unstable updated at same time.

it looks like ipw2200 is thinking that ieee80211 is not compiled in, but
I did select it as a module?

drivers/net/wireless/ipw2200.c:6676: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:6677: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:6679: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:6679: error: 'WLAN_AUTH_SHARED_KEY'
undeclared (first use in this function)
drivers/net/wireless/ipw2200.c:6686: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:6686: error: 'SEC_ENABLED' undeclared
(first use in this function)
drivers/net/wireless/ipw2200.c:6687: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:6689: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:6691: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:6697: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:6697: error: 'SEC_LEVEL' undeclared
(first use in this function)
drivers/net/wireless/ipw2200.c:6698: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:6699: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c: In function 'init_supported_rates':
drivers/net/wireless/ipw2200.c:6727: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:6728: error: 'IEEE80211_52GHZ_BAND'
undeclared (first use in this function)
drivers/net/wireless/ipw2200.c:6731: error: 'IEEE80211_CCK_MODULATION'
undeclared (first use in this function)
drivers/net/wireless/ipw2200.c:6732: error:
'IEEE80211_OFDM_DEFAULT_RATES_MASK' undeclared (first use in this
function)
drivers/net/wireless/ipw2200.c:6739: error:
'IEEE80211_CCK_DEFAULT_RATES_MASK' undeclared (first use in this
function)
drivers/net/wireless/ipw2200.c:6740: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:6740: error: 'IEEE80211_OFDM_MODULATION'
undeclared (first use in this function)
drivers/net/wireless/ipw2200.c: In function 'ipw_net_init':
drivers/net/wireless/ipw2200.c:6887: warning: initialization makes
pointer from integer without a cast
drivers/net/wireless/ipw2200.c: In function 'ipw_pci_probe':
drivers/net/wireless/ipw2200.c:6970: warning: implicit declaration of
function 'alloc_ieee80211'
drivers/net/wireless/ipw2200.c:6970: warning: assignment makes pointer
from integer without a cast
drivers/net/wireless/ipw2200.c:6976: warning: assignment makes pointer
from integer without a cast
drivers/net/wireless/ipw2200.c:7060: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:7069: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:7078: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:7079: error: 'IEEE80211_52GHZ_BAND'
undeclared (first use in this function)
drivers/net/wireless/ipw2200.c:7079: error: 'IEEE80211_24GHZ_BAND'
undeclared (first use in this function)
drivers/net/wireless/ipw2200.c:7080: error: 'IEEE80211_OFDM_MODULATION'
undeclared (first use in this function)
drivers/net/wireless/ipw2200.c:7081: error: 'IEEE80211_CCK_MODULATION'
undeclared (first use in this function)
drivers/net/wireless/ipw2200.c:7083: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:7083: error: 'IEEE_A' undeclared (first
use in this function)
drivers/net/wireless/ipw2200.c:7083: error: 'IEEE_G' undeclared (first
use in this function)
drivers/net/wireless/ipw2200.c:7083: error: 'IEEE_B' undeclared (first
use in this function)
drivers/net/wireless/ipw2200.c:7094: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:7099: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:7102: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:7103: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:7105: error:
'IEEE80211_DEFAULT_RATES_MASK' undeclared (first use in this function)
drivers/net/wireless/ipw2200.c:7126: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:7127: error: dereferencing pointer to
incomplete type
drivers/net/wireless/ipw2200.c:7172: warning: implicit declaration of
function 'free_ieee80211'
make[4]: *** [drivers/net/wireless/ipw2200.o] Error 1
make[3]: *** [drivers/net/wireless] Error 2
make[2]: *** [drivers/net] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/root/linux-2.6'
make: *** [stamp-build] Error 2
debian:~/linux-2.6#

.Alejandro

