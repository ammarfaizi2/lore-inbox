Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277968AbRJIVAY>; Tue, 9 Oct 2001 17:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277974AbRJIVAP>; Tue, 9 Oct 2001 17:00:15 -0400
Received: from [213.97.184.209] ([213.97.184.209]:640 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S277968AbRJIVAE>;
	Tue, 9 Oct 2001 17:00:04 -0400
Date: Tue, 9 Oct 2001 23:00:07 +0200 (CEST)
From: German Gomez Garcia <german@piraos.com>
To: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: More on the 760MP
Message-ID: <Pine.LNX.4.33.0110092255500.2610-102000@hal9000.piraos.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1641402808-2091151308-1002661207=:2610"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1641402808-2091151308-1002661207=:2610
Content-Type: TEXT/PLAIN; charset=US-ASCII

	Hello,

	I'm currently running 2.4.10-ac10 on a Tyan Tiger MP with dual
Athlon 1.4 (Thunderbird), I'm having no important problems (I don't know
about UDMA100), but I'm having problems with the noapic option (that
appears in the boot log to correct an AMD errata). although I set it and
it appears in the /proc/cmdline that message stills apears. Also I'm
unable to get correct readings with lm_sensors (CVS), I've been enable
to detect the w83781d chip using the i2c-amd756 SMbus but half of the
times the kernel hangs up when loading this module. Also when I lspci
I get lots of unkown devices.

	I've attached both the boot log and the output of lspci -vvv.

	If you need more info just tell me, I'll try my best.

	Regards,

	- german

-------------------------------------------------------------------------
German Gomez Garcia          | Send email with "SEND GPG KEY" as subject
<german@piraos.com>          | to receive my GnuPG public key.

--1641402808-2091151308-1002661207=:2610
Content-Type: APPLICATION/octet-stream; name="boot.log.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0110092300070.2610@hal9000.piraos.com>
Content-Description: 
Content-Disposition: attachment; filename="boot.log.gz"

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
AAA=
--1641402808-2091151308-1002661207=:2610
Content-Type: APPLICATION/octet-stream; name="lspci.out.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0110092300071.2610@hal9000.piraos.com>
Content-Description: 
Content-Disposition: attachment; filename="lspci.out.gz"

H4sICCRkwzsAA2xzcGNpLm91dADtmWtv2kgUhj/Drzj7LRFxd8aYYFBTiVuz
SKFLcZOuVOXD2B5gVOyxxkNa+uv3jDEUCHHIrcquipRg4xlf3vc5c86MCWkS
8obAXzLV4CsRTngTWuENiwMewkAESkKX34iAp024jL/G8lsMYfYD1AkJ4Ejx
G6D0uFzqyFgrOWtC/8+/LRjwqALteTpgqeaqAl7Cg84imPHs0Of+hysLrs5b
XixlYsGQqZ5SFniaJ4mIJ7jVG40seI+923bbKpc8zfQc76HDkgqcng6mPyy4
7L7/2WR9jm7vyutdnEU8FPMI3n1q+VJpC96uNwbZRgXeLa/xdmi+yqULpnkc
LJpw6kDKdbk04hMhYyBNc8dSLYBpGJPlB46qtuULfQKJ4mOugynzZ/x43Ylu
duIuIdUDOtmZdpDg3aWmH3WrBL6EIjXNwmuUmCXMFzOhhbHjCyPX0Dofwg1X
adb/DSmX1kqNPp7RGnjtFurl4FVRqs8WjPApz2yK7ToyilgcbjXEs1n7WpcJ
ckKRk2Gn/whMwm06Ki9Jh7Wko/I0Oqw76Wg0lnS0zfUSJSKmFmeEnOCvgYzD
bI/i3hxPE4rYCJjt88CaLc9xdtool4zRPp+KOFzrabgyfFkZYePxuFzKGdpp
yF2aNbG4O84+5dJwAyiI9vdiJO/lr3q1s0MdjbagPkIvVsp+kH0PcUAL0KuV
ICOOD76hegZFHaHAtg+GwqFkOXYQ+/hgOirPRccTx4676SAZHLkyFPrdHogY
H2LMggeJQ3Nx6DEcJUpOLDEGl+1TynrZOHoxpXZGWWdn7DOBsNKxCu0H01Vd
C7gnM21oZr24ZpWnapar4MCl14b8WWZcPUQNJ1ejvoETJYcH3lqayuuS5idO
LoGIfT8BerrEqm+iTs0TjYO0iKELSs41SqUl9EcfsWLZn9+RujDYStWxjK3t
dJ350cBxz+t4fUi1VGzCIdgwxltEvpApXMiJCKAfB2/gaCxVxNVsAR86o2Oo
VQO3Udtg1Jv76QJVj27ZR0NOm9UGqT+HW5XXEfxY10QiPjGDQOaa7dSNbScQ
sGDKYSZiDqn4gQ9PblnZKrRyu4Ayg8idJZl9j88bZdl2R3oIIAwBGcxnWhiV
GNyIkMstSNpKyq9acY4xrfCWmTYXa2u37m5kxgIunFOKxTuhv7D0fukoxujN
uHBW0Vy194bzLQbI/nA2bjkFlXfuFN106rdHxR45S4vsWm3p0SqRP8Gi2n0W
+dvBxOah2A6mjuLozQ2HC+anOJeBC9z5I/eoVuwRJXbTRUx+YXG1dwr7jB7Z
uUfkYRYVjKSuGUl35p9hcA1D+Y0rGLAYc2DEY72ejJop5vsZm2DD4aDXmX21
oDX/PvxmHs/r4z+Kf7ZlDlobs9YuyX7pxcZ905TPzgh+BWyGE6ll6xwJLK/j
ZK5XPh6AQ5fNJ1OUwJdMhYfDYVLF/wiO2+sbu6sO7uuyOsDo7+kpVzHXWzZX
OzLaGpmrQYPU2ibvt1nKP/0DX4wnMubXS7erpNht4tebeIbaLyyMn2c1qyCl
5qUWzccClzy60qrdzYxTWGg59xRazwtbBWGrPBq28DdsrwK2omTkuEW0uf8V
2rA0rCFt6CWCFiVIlVm922RuwHDzO5wrlkxFkJ5kc8lbJJGavZpKOvcgZ/tN
m9Ybxcg965rIC2Wzx1ab7FHr93Sn08GTRff+jg/B0S7EsfKUTLt7H+P7Xi5U
6YEvF1YN73y58C/Y69QqhRoAAA==
--1641402808-2091151308-1002661207=:2610--
