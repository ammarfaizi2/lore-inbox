Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUDJKtg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 06:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUDJKtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 06:49:36 -0400
Received: from viefep20-int.chello.at ([213.46.255.26]:9298 "EHLO
	viefep20-int.chello.at") by vger.kernel.org with ESMTP
	id S261992AbUDJKtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 06:49:32 -0400
Date: Sat, 10 Apr 2004 12:51:36 +0200
From: Dub Spencer <dub@lazy.shacknet.nu>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linuxbugs@nvidia.com
Subject: 2.6.5 hangs when burning cdrom while watching tv
Message-ID: <20040410105136.GA2177@lazy.shacknet.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hello,

when motv is running (bttv module, overlay mode) and then burning a cd
at higher speeds, the system stops: ie. shift led on keyboard no longer
lights.  when burning at lower speeds (10x for cdrw) the system only
hung, when starting mozilla firebird (aka heavy application).

unfortunately, there is nothing in the logs; kernel configured for
preemption, nvidia binary module loaded. uname, lspci, lsmod and
config.gz attached.

anything I can do, to get an oops?

regards

dub

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=uname

Linux lazy 2.6.5 #13 Sun Apr 4 17:08:39 CEST 2004 i686 GNU/Linux

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:00:08.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
0000:00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
0000:00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV11DDR [GeForce2 MX 100 DDR/200 DDR] (rev b2)

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lsmod

Module                  Size  Used by
snd_seq_midi            6240  - 
snd_seq_oss            31488  - 
snd_seq_midi_event      6080  - 
snd_seq                50736  - 
snd_via82xx            21984  - 
snd_mpu401_uart         5952  - 
ehci_hcd               23940  - 
uhci_hcd               29424  - 
usbcore                90844  - 
snd_bt87x              10980  - 
tuner                  16908  - 
tvaudio                20268  - 
bttv                  141708  - 
video_buf              16388  - 
i2c_algo_bit            8680  - 
v4l2_common             4704  - 
btcx_risc               3656  - 
videodev                6720  - 
snd_ens1371            19748  - 
snd_rawmidi            20000  - 
snd_seq_device          6248  - 
snd_pcm_oss            48772  - 
snd_mixer_oss          16960  - 
snd_pcm                84900  - 
snd_page_alloc          8740  - 
snd_timer              21092  - 
snd_ac97_codec         61220  - 
snd                    44036  - 
soundcore               6752  - 
8139too                20288  - 
w83627hf               26276  - 
eeprom                  6024  - 
i2c_sensor              2144  - 
i2c_isa                 1472  - 
i2c_viapro              5676  - 
i2c_core               17924  - 
loop                   12232  - 
nvidia               2067400  - 

--nFreZHaLTZJo0R7j
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

H4sICBfOd0AAA2NvbmZpZwB9l8t66ygMgPfzNG3SSdPFLDBgm2Nu4ZI4Z8MTnAeYtx+RtLUE
7mzyRb+EuMmS4M6Oairr+fTPv3/xp2BM3oSsxCvSTdLKoHhRkRVh2KaQqweFkTYxvVGuJbOF
O+OVlhuOiVnBtLOIDcEt0hZnSzQemd4Ylu7xqjwngCc04eyS13nawMK0jncTNzLmJFe0cO80
cqBc5LMUxTrne8piz4RkQiu8FeNE1hKZuiE6LZOsGs+CQcsDsklwDQXvzizvVMmNX/k8Ubgy
gXyEW5SmVCvAhenJBZVmQ4fcfLm5sMTiFqpQ9qp943+gd/BYpPNMdIMn52BGr3jrM0ldcpSB
O3+nOqDF++AKHCVfYja9+iisu23YBymNT42d35kXoHI91o4zvbdMtwNTbIDhsgMQLHZkJPCt
m9U0G4n2Y1IIKFDZVULo8LocdIweDYhuTDcWZIk5emnRHTPuFZXK4FxqUD33AMcFv40main9
HoPTdbyMsXWeU3K2gSNrSR0sY3TtdGmWweDT+XTaTiN569DdurV73m4dckDCB00sQIC4ZPZO
0QBfLyVCBckTZcY8BUotM/jjHpQdTSpSj4jpBS73WkbRM10zy5/vLCJkb/ITFCqiWPkExWSd
VE0t+4O4IENKYnEZIR1DwFPFZ27fdULO9CmXONfgVOHSj/g/V1A2SuvukxWWk+sHMVJpvuhV
sfOBr+v60yzdDNR75FFt91ClPvq/HEaxWfI5PNnUjA5QSkIqOttIZykXzQ51od/2VuJIY3zp
ZQg+nHWzVWijijgAAS6UfOaAyqM8dajw4dLDOQ07cMTZ73t8/N1DH3A0fdGwN38cd+ZP8qJ3
6DD2cNr1KqJhYem5smAfI1VcXANkTMqw5JoT5Dp2oCSurMAdxJciOOgs3n7gPR5vPcvHw874
ePX79NRj6GYUp7NBsAJCOxHZmDsJxiJrjiZBZZSi3sk3e349fiTnNifwNZYw1zaoRxDKJNdY
n1MjQvqCWg8r/YkXH1lGhx5dtqJMkIrrR4e4JJH4EIs6v7wdWs+LvA+OBRRLX6SwtAxidyW4
yXv0LhH5vSb8H9peW9s+VPNvPasLhHbkfPj7pYPcBWRZM8DHufh0R1ep5cT4vYEhoc9WHTiq
NgcO+Qu2CAdNYO0TB5UohCafArhRSJGURWlrxd9S4UOO1fZ0PrFecTsfT4f3eew10IAEZ3AA
CekKWesTDen8dm5hylBzOss89oP52jKFB06sv6bHJ7NzezUK0UYaoUBWwWuqyHNDQWA3o4Si
MMpLlpa3g12E5j6jTFmhUasMVdVN1MNvvw8VcQNRs7Nc4/Pby2vJLCSqYPzjHQ4E+gvK4W7e
V4rgel+P768UPso3rok5DkQoz7yFy3GlcoY+YeaC2uZdGiGjs0lSOCvRgSYlyTUdah/wpwHw
1EopELtja3fcsfs1oClBbQbOoDhvbAWIN6qi+zidXojvX5DZcYLOYiR6eIEQ2UThIiHX1sSm
kVp0DdADLDQRJeOxSWAGi9EMxGWVLRQmIUcGjSpKoI/1wXM4qaTw68KSqlurYhrR1y5Z0Pfa
cNjUvD9HVSPc+PJkzTvNw1Q4gfPAcbV9vHThVQBNC31LPR7k/wFFXJNkKBEAAA==

--nFreZHaLTZJo0R7j--
