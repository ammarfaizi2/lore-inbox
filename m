Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVF2PsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVF2PsT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVF2PsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:48:19 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:36025 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261430AbVF2PpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:45:13 -0400
Message-Id: <200506291543.j5TFhDIJ024088@laptop11.inf.utfsm.cl>
To: abonilla@linuxwireless.org
cc: "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Jeff Chua'" <jeff96@silk.corp.fedex.com>,
       ipw2100-devel@lists.sourceforge.net,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: ipw2200 can't compile under linux 2.6.13-rc1 
In-Reply-To: Message from "Alejandro Bonilla" <abonilla@linuxwireless.org> 
   of "Wed, 29 Jun 2005 06:43:45 CST."
 <001101c57ca8$30c7d640$600cc60a@amer.sykes.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date: Wed, 29 Jun 2005 11:43:13 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 29 Jun 2005 11:43:20 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1

Alejandro Bonilla <abonilla@linuxwireless.org> wrote:
> > On Wed, 2005-06-29 at 18:12 +0800, Jeff Chua wrote:
> > > ipw2200-1.0.4 can't be compiled under linux 2.6.13-rc1.
> > > 
> > > ipw2200-1.0.4 compiled fine with linux 2.6.12.
> > 
> > soo..... what's the error ?

> Probably the same reason why it won't compile in 2.6.12.
> 
> Is it the is_multicast_ethr_addr error?
> 
> http://ipw2200.sourceforge.net/#patches

Nope, I've got that fixed here. It gets tons of errors and warnings in
ipw2200.c, the interface to devices has changed. Haven't found time to look
into it yet...


--=-=-=
Content-Type: text/x-c; charset=utf-8
Content-Disposition: attachment; filename=ipw.out
Content-Transfer-Encoding: quoted-printable
Content-Description: Output compiling ipw2200-1.0.4 against 2.6.13-rc1

make -C /usr/src/ipw2200-1.0.4/../linux-2.6.git SUBDIRS=3D/usr/src/ipw2200-=
1.0.4 MODVERDIR=3D/usr/src/ipw2200-1.0.4 modules
make[1]: Entering directory `/usr/src/linux-2.6.git'
  CC [M]  /usr/src/ipw2200-1.0.4/ipw2200.o
/usr/src/ipw2200-1.0.4/ipw2200.c:66: error: variable =E2=80=98def_qos_param=
eters_OFDM=E2=80=99 has initializer but incomplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:68: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:68: error: (near initialization for =E2=80=
=98def_qos_parameters_OFDM=EF=BF=BD)
/usr/src/ipw2200-1.0.4/ipw2200.c:68: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:68: warning: (near initialization for =E2=
=80=98def_qos_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:69: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:69: error: (near initialization for =E2=80=
=98def_qos_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:69: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:69: warning: (near initialization for =E2=
=80=98def_qos_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:70: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:70: error: (near initialization for =E2=80=
=98def_qos_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:70: error: =E2=80=98QOS_AIFSN_MIN_VALUE=E2=
=80=99 undeclared here (not in a function)
/usr/src/ipw2200-1.0.4/ipw2200.c:70: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:70: warning: (near initialization for =E2=
=80=98def_qos_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:71: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:71: error: (near initialization for =E2=80=
=98def_qos_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:71: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:71: warning: (near initialization for =E2=
=80=98def_qos_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:72: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:72: error: (near initialization for =E2=80=
=98def_qos_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:72: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:72: warning: (near initialization for =E2=
=80=98def_qos_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:75: error: variable =E2=80=98def_qos_param=
eters_CCK=E2=80=99 has initializer but incomplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:77: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:77: error: (near initialization for =E2=80=
=98def_qos_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:77: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:77: warning: (near initialization for =E2=
=80=98def_qos_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:78: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:78: error: (near initialization for =E2=80=
=98def_qos_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:78: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:78: warning: (near initialization for =E2=
=80=98def_qos_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:79: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:79: error: (near initialization for =E2=80=
=98def_qos_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:79: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:79: warning: (near initialization for =E2=
=80=98def_qos_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:80: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:80: error: (near initialization for =E2=80=
=98def_qos_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:80: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:80: warning: (near initialization for =E2=
=80=98def_qos_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:81: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:81: error: (near initialization for =E2=80=
=98def_qos_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:81: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:81: warning: (near initialization for =E2=
=80=98def_qos_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:84: error: variable =E2=80=98def_parameter=
s_OFDM=E2=80=99 has initializer but incomplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:86: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:86: error: (near initialization for =E2=80=
=98def_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:86: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:86: warning: (near initialization for =E2=
=80=98def_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:87: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:87: error: (near initialization for =E2=80=
=98def_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:87: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:87: warning: (near initialization for =E2=
=80=98def_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:88: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:88: error: (near initialization for =E2=80=
=98def_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:88: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:88: warning: (near initialization for =E2=
=80=98def_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:89: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:89: error: (near initialization for =E2=80=
=98def_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:89: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:89: warning: (near initialization for =E2=
=80=98def_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:90: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:90: error: (near initialization for =E2=80=
=98def_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:90: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:90: warning: (near initialization for =E2=
=80=98def_parameters_OFDM=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:93: error: variable =E2=80=98def_parameter=
s_CCK=E2=80=99 has initializer but incomplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:95: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:95: error: (near initialization for =E2=80=
=98def_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:95: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:95: warning: (near initialization for =E2=
=80=98def_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:96: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:96: error: (near initialization for =E2=80=
=98def_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:96: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:96: warning: (near initialization for =E2=
=80=98def_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:97: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:97: error: (near initialization for =E2=80=
=98def_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:97: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:97: warning: (near initialization for =E2=
=80=98def_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:98: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:98: error: (near initialization for =E2=80=
=98def_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:98: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:98: warning: (near initialization for =E2=
=80=98def_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:99: error: extra brace group at end of ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:99: error: (near initialization for =E2=80=
=98def_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:99: warning: excess elements in struct ini=
tializer
/usr/src/ipw2200-1.0.4/ipw2200.c:99: warning: (near initialization for =E2=
=80=98def_parameters_CCK=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:102: error: =E2=80=98QOS_OUI_LEN=E2=80=99 =
undeclared here (not in a function)
/usr/src/ipw2200-1.0.4/ipw2200.c:114: warning: =E2=80=98struct ieee80211_qo=
s_information_element=E2=80=99 declared inside parameter list
/usr/src/ipw2200-1.0.4/ipw2200.c:114: warning: its scope is only this defin=
ition or declaration, which is probably not what you want
/usr/src/ipw2200-1.0.4/ipw2200.c:1081: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1126: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1126: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1156: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1156: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1164: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1171: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1179: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1191: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1203: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1215: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1227: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1245: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1245: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1267: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1267: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1289: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1289: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1313: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1313: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1337: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1337: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1362: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1362: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1428: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1428: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98store_speed_scan=E2=
=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:1458: warning: implicit declaration of fun=
ction =E2=80=98ieee80211_is_valid_channel=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: At top level:
/usr/src/ipw2200-1.0.4/ipw2200.c:1480: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1480: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1502: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:1502: warning: initialization from incompa=
tible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_irq_tasklet=E2=
=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:1616: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_adapter_restart=
=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:1869: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_gather_stats=E2=
=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:3834: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98perfect_rssi=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:3834: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98worst_rssi=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:3835: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98perfect_rssi=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:3835: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98worst_rssi=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:3836: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98perfect_rssi=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:3837: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98perfect_rssi=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:3837: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98worst_rssi=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:3838: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98perfect_rssi=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:3839: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98perfect_rssi=EF=BF=BD
/usr/src/ipw2200-1.0.4/ipw2200.c:3839: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98worst_rssi=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:3840: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98perfect_rssi=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:3840: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98worst_rssi=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_adhoc_create=E2=
=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:5296: warning: implicit declaration of fun=
ction =E2=80=98ieee80211_get_geo=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:5296: warning: initialization makes pointe=
r from integer without a cast
/usr/src/ipw2200-1.0.4/ipw2200.c:5300: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:5303: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:5306: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_send_tgi_tx_key=
=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:5349: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:5354: error: =E2=80=98SCM_TEMPORAL_KEY_LEN=
GTH=E2=80=99 undeclared (first use in this function)
/usr/src/ipw2200-1.0.4/ipw2200.c:5354: error: (Each undeclared identifier i=
s reported only once
/usr/src/ipw2200-1.0.4/ipw2200.c:5354: error: for each function it appears =
in.)
/usr/src/ipw2200-1.0.4/ipw2200.c:5354: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:5354: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_send_wep_keys=E2=
=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:5385: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:5390: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:5391: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:5391: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_set_hwcrypto_key=
s=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:5402: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:5404: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:5407: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:5418: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:5421: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_request_scan=E2=
=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:5596: warning: assignment makes pointer fr=
om integer without a cast
/usr/src/ipw2200-1.0.4/ipw2200.c:5689: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:5691: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:5695: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:5709: error: =EF=BF=BDIEEE80211_24GHZ_CHAN=
NELS=E2=80=99 undeclared (first use in this function)
/usr/src/ipw2200-1.0.4/ipw2200.c:5711: error: array index in non-array init=
ializer
/usr/src/ipw2200-1.0.4/ipw2200.c:5711: error: (near initialization for =E2=
=80=98channels=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:5709: warning: unused variable =E2=80=98ch=
annels=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:5743: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:5745: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:5749: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_wpa_set_encrypti=
on=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:6070: error: =E2=80=98struct ieee80211_sec=
urity=E2=80=99 has no member named =E2=80=98encrypt=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6073: warning: implicit declaration of fun=
ction =E2=80=98ieee80211_crypt_delayed_deinit=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6078: error: =E2=80=98struct ieee80211_sec=
urity=E2=80=99 has no member named =E2=80=98encrypt=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6086: warning: implicit declaration of fun=
ction =E2=80=98ieee80211_get_crypto_ops=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6086: warning: assignment makes pointer fr=
om integer without a cast
/usr/src/ipw2200-1.0.4/ipw2200.c:6089: warning: assignment makes pointer fr=
om integer without a cast
/usr/src/ipw2200-1.0.4/ipw2200.c:6092: warning: assignment makes pointer fr=
om integer without a cast
/usr/src/ipw2200-1.0.4/ipw2200.c:6095: warning: assignment makes pointer fr=
om integer without a cast
/usr/src/ipw2200-1.0.4/ipw2200.c:6105: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6111: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6116: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_crypt_data=
=E2=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c:6116: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_crypt_data=
=E2=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c:6116: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_crypt_data=
=E2=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c:6116: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_crypt_data=
=E2=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c:6116: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_crypt_data=
=E2=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c:6116: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_crypt_data=
=E2=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c:6117: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6118: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6118: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6119: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6120: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6122: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6132: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6133: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6135: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_qos_handle_probe=
_reponse=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:6274: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_qos_paramet=
ers=E2=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c:6277: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6277: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6279: error: =E2=80=98NETWORK_HAS_QOS_MASK=
=E2=80=99 undeclared (first use in this function)
/usr/src/ipw2200-1.0.4/ipw2200.c:6280: error: =E2=80=98NETWORK_HAS_QOS_PARA=
METERS=E2=80=99 undeclared (first use in this function)
/usr/src/ipw2200-1.0.4/ipw2200.c:6281: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6281: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6283: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6285: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6285: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6286: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6286: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6293: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6293: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6296: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6296: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6298: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6303: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6304: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: At top level:
/usr/src/ipw2200-1.0.4/ipw2200.c:6327: warning: =E2=80=98struct ieee80211_q=
os_data=E2=80=99 declared inside parameter list
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_qos_activate=E2=
=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:6330: error: array type has incomplete ele=
ment type
/usr/src/ipw2200-1.0.4/ipw2200.c:6332: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_qos_paramet=
ers=E2=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c:6355: error: =E2=80=98QOS_QUEUE_NUM=E2=80=
=99 undeclared (first use in this function)
/usr/src/ipw2200-1.0.4/ipw2200.c:6380: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6381: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6382: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6385: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6330: warning: unused variable =E2=80=98qo=
s_parameters=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_qos_set_info_ele=
ment=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:6411: error: storage size of =E2=80=98qos_=
info=E2=80=99 isn=E2=80=99t known
/usr/src/ipw2200-1.0.4/ipw2200.c:6417: error: =E2=80=98QOS_ELEMENT_ID=E2=80=
=99 undeclared (first use in this function)
/usr/src/ipw2200-1.0.4/ipw2200.c:6418: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_qos_informa=
tion_element=E2=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c:6420: error: =E2=80=98QOS_VERSION_1=E2=80=
=99 undeclared (first use in this function)
/usr/src/ipw2200-1.0.4/ipw2200.c:6424: error: =E2=80=98QOS_OUI_TYPE=E2=80=
=99 undeclared (first use in this function)
/usr/src/ipw2200-1.0.4/ipw2200.c:6425: error: =E2=80=98QOS_OUI_INFO_SUB_TYP=
E=E2=80=99 undeclared (first use in this function)
/usr/src/ipw2200-1.0.4/ipw2200.c:6411: warning: unused variable =E2=80=98qo=
s_info=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_qos_association=
=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:6444: error: variable =E2=80=98ibss_data=
=E2=80=99 has initializer but incomplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6445: error: unknown field =E2=80=98suppor=
ted=E2=80=99 specified in initializer
/usr/src/ipw2200-1.0.4/ipw2200.c:6445: warning: excess elements in struct i=
nitializer
/usr/src/ipw2200-1.0.4/ipw2200.c:6445: warning: (near initialization for =
=E2=80=98ibss_data=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:6446: error: unknown field =E2=80=98active=
=E2=80=99 specified in initializer
/usr/src/ipw2200-1.0.4/ipw2200.c:6446: warning: excess elements in struct i=
nitializer
/usr/src/ipw2200-1.0.4/ipw2200.c:6446: warning: (near initialization for =
=E2=80=98ibss_data=E2=80=99)
/usr/src/ipw2200-1.0.4/ipw2200.c:6444: error: storage size of =E2=80=98ibss=
_data=E2=80=99 isn=E2=80=99t known
/usr/src/ipw2200-1.0.4/ipw2200.c:6458: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6466: warning: passing argument 2 of =E2=
=80=98ipw_qos_activate=E2=80=99 from incompatible pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:6472: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6444: warning: unused variable =E2=80=98ib=
ss_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_qos_association_=
resp=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:6490: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_qos_paramet=
ers=E2=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c:6505: error: =E2=80=98NETWORK_HAS_QOS_PARA=
METERS=E2=80=99 undeclared (first use in this function)
/usr/src/ipw2200-1.0.4/ipw2200.c:6506: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_qos_data=E2=
=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c:6506: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6506: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6506: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_qos_data=E2=
=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c:6506: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6506: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6506: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_qos_data=E2=
=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c:6507: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6508: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6508: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6510: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6510: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6515: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6515: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6517: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6517: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6519: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6520: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_qos_set_tx_queue=
_command=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:6609: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6615: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6617: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6617: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6620: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6621: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6635: error: =E2=80=98IEEE80211_STYPE_QOS_=
DATA=E2=80=99 undeclared (first use in this function)
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_bg_qos_activate=
=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:6661: error: =E2=80=98struct ieee80211_net=
work=E2=80=99 has no member named =E2=80=98qos_data=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_send_qos_params_=
command=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:6700: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_qos_paramet=
ers=E2=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c:6708: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_qos_paramet=
ers=E2=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c:6708: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_qos_paramet=
ers=E2=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c:6708: error: invalid application of =E2=80=
=98sizeof=E2=80=99 to incomplete type =E2=80=98struct ieee80211_qos_paramet=
ers=E2=80=99=20
/usr/src/ipw2200-1.0.4/ipw2200.c: At top level:
/usr/src/ipw2200-1.0.4/ipw2200.c:6718: warning: =E2=80=98struct ieee80211_q=
os_information_element=E2=80=99 declared inside parameter list
/usr/src/ipw2200-1.0.4/ipw2200.c:6719: error: conflicting types for =E2=80=
=98ipw_send_qos_info_command=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:114: error: previous declaration of =E2=80=
=98ipw_send_qos_info_command=E2=80=99 was here
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_send_qos_info_co=
mmand=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:6722: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6730: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6730: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:6730: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_associate_networ=
k=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:6768: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6771: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:6807: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_rebuild_decrypte=
d_skb=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:7098: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:7119: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98is_network_packet=E2=
=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:7180: warning: implicit declaration of fun=
ction =E2=80=98is_broadcast_ether_addr=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_handle_mgmt_pack=
et=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:7246: error: =E2=80=98ETH_P_80211_STATS=E2=
=80=99 undeclared (first use in this function)
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_wx_set_freq=E2=
=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:7518: warning: implicit declaration of fun=
ction =E2=80=98ieee80211_freq_to_channel=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =EF=BF=BDipw_wx_get_range=E2=
=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:7653: warning: initialization makes pointe=
r from integer without a cast
/usr/src/ipw2200-1.0.4/ipw2200.c:7665: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98worst_rssi=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:7695: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:7697: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:7698: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:7704: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:7706: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c:7707: error: dereferencing pointer to inco=
mplete type
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_sw_reset=E2=80=
=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:8655: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98geography=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:8655: error: =E2=80=98IEEE80211_GEO_001=E2=
=80=99 undeclared (first use in this function)
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_tx_skb=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:8999: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9026: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9036: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98shim__set_security=
=E2=80=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:9448: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9450: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9452: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9452: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9454: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9458: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9463: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9464: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9466: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9469: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9472: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9473: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9474: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9483: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9484: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9485: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9492: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9492: error: =E2=80=98struct ieee80211_sec=
urity=E2=80=99 has no member named =E2=80=98encrypt=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9495: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9496: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9497: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98sec=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c: In function =E2=80=98ipw_pci_probe=E2=80=
=99:
/usr/src/ipw2200-1.0.4/ipw2200.c:9945: warning: assignment from incompatibl=
e pointer type
/usr/src/ipw2200-1.0.4/ipw2200.c:9949: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98handle_management_frame=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9952: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98perfect_rssi=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9953: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98worst_rssi=E2=80=99
/usr/src/ipw2200-1.0.4/ipw2200.c:9963: error: =E2=80=98struct ieee80211_dev=
ice=E2=80=99 has no member named =E2=80=98spy_data=E2=80=99
make[2]: *** [/usr/src/ipw2200-1.0.4/ipw2200.o] Error 1
make[1]: *** [_module_/usr/src/ipw2200-1.0.4] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.git'
make: *** [modules] Error 2

--=-=-=
Content-Type: text/plain; charset=iso-8859-1

-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

--=-=-=--
