Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWCFBln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWCFBln (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 20:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWCFBlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 20:41:42 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:16261 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751519AbWCFBlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 20:41:42 -0500
Date: Mon, 6 Mar 2006 02:41:39 +0100 (CET)
From: Czigola Gabor <czigola@elte.hu>
X-X-Sender: czigola@login08.caesar.elte.hu
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: on 2.6.15.5 (i386) ipw2200 fails to load
Message-ID: <Pine.LNX.4.58.0603060158270.15054@login08.caesar.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_40,UPPERCASE_25_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.1 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.3921]
	0.0 UPPERCASE_25_50        message body is 25-50% uppercase
	1.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First at all, I hope I'm right here, and second I apologize for my
poor English.

With 2.6.13.4 kernel my intel IPW2200BG worked wery well, of course with
iee80211+ipw2200+firmware from sourceforge.

Now I tried to use the built in dirver of the 2.6.15.5 kernel, but uppon
booting I get just those errors in dmesg listed above.

I would like to deliver more information, but I don't now how. I'm not a
toatlly newbie at all, but I'm not also a kernel-hacker-gosu at all.
So I don't now how to begin debug this bug.

(When I try to make install the actual ipw driver from sourceforge, I get
 the same errors.)

Thank you all:
Czigola, Gabor
czigola@elte.hu

(Maybe) relevant .config sections:
CONFIG_IEEE80211=y
# CONFIG_IEEE80211_DEBUG is not set
CONFIG_IEEE80211_CRYPT_WEP=y
CONFIG_IEEE80211_CRYPT_CCMP=y
CONFIG_IEEE80211_CRYPT_TKIP=y
(...)
# Wireless LAN (non-hamradio)
CONFIG_NET_RADIO=y
# Obsolete Wireless cards support (pre-802.11)
CONFIG_STRIP=m
CONFIG_ARLAN=m
CONFIG_WAVELAN=m
CONFIG_PCMCIA_WAVELAN=m
CONFIG_PCMCIA_NETWAVE=m
# Wireless 802.11 Frequency Hopping cards support
CONFIG_PCMCIA_RAYCS=m
# Wireless 802.11b ISA/PCI cards support
CONFIG_IPW2100=m
CONFIG_IPW2100_MONITOR=y
# CONFIG_IPW_DEBUG is not set
CONFIG_IPW2200=m
CONFIG_AIRO=m
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
CONFIG_NORTEL_HERMES=m
CONFIG_PCI_HERMES=m
CONFIG_ATMEL=m
CONFIG_PCI_ATMEL=m
# Wireless 802.11b Pcmcia/Cardbus cards support
CONFIG_PCMCIA_HERMES=m
CONFIG_PCMCIA_SPECTRUM=m
CONFIG_AIRO_CS=m
CONFIG_PCMCIA_ATMEL=m
CONFIG_PCMCIA_WL3501=m
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
CONFIG_PRISM54=m
CONFIG_HOSTAP=m
# CONFIG_HOSTAP_FIRMWARE is not set
CONFIG_HOSTAP_PLX=m
CONFIG_HOSTAP_PCI=m
CONFIG_HOSTAP_CS=m
CONFIG_NET_WIRELESS=y

dmesg:
ipw2200: Unknown symbol ieee80211_wx_get_encodeext
ipw2200: Unknown symbol ieee80211_wx_set_encode
ipw2200: Unknown symbol ieee80211_wx_get_encode
ipw2200: Unknown symbol ieee80211_txb_free
ipw2200: Unknown symbol ieee80211_wx_set_encodeext
ipw2200: Unknown symbol iw_handler_set_spy
ipw2200: Unknown symbol ieee80211_wx_get_scan
ipw2200: Unknown symbol escape_essid
ipw2200: Unknown symbol iw_handler_get_thrspy
ipw2200: Unknown symbol ieee80211_rx
ipw2200: Unknown symbol wireless_send_event
ipw2200: Unknown symbol iw_handler_get_spy
ipw2200: Unknown symbol ieee80211_rx_mgt
ipw2200: Unknown symbol free_ieee80211
ipw2200: Unknown symbol iw_handler_set_thrspy
ipw2200: Unknown symbol alloc_ieee80211

ver_linux output:
Linux kamorka 2.6.15.5 #3 PREEMPT Sat Mar 4 03:34:59 CET 2006 i686
GNU/Linux

Gnu C                  4.0.3
Gnu make               3.81rc1
binutils               2.16.91
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39-WIP
reiserfsprogs          line
reiser4progs           line
PPP                    2.4.4b1
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.94
udev                   086
Modules Loaded         fglrx serio_raw yenta_socket rsrc_nonstatic
snd_intel8x0m
