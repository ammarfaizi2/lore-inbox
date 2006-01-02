Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWABNAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWABNAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 08:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWABNAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 08:00:22 -0500
Received: from mail.gmx.de ([213.165.64.21]:32982 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750710AbWABNAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 08:00:21 -0500
X-Authenticated: #5339386
Date: Mon, 2 Jan 2006 13:57:53 +0100
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: oops in kernel 2.6.15-rc7
Message-ID: <20060102125750.GB21933@sidney>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051230194435.GA7088@sidney> <43B5B37F.4040508@liberouter.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <43B5B37F.4040508@liberouter.org>
User-Agent: Mutt/1.5.11
From: Mathias Klein <ma_klein@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: multipart/mixed; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 30, 2005 at 11:23:59PM +0100, Jiri Slaby wrote:
> Mathias Klein napsal(a):
> > Hello,
> >=20
> > i recently got another oops. As suggested by Pekka Enberg I've enabled
> > CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC.
> >=20
> > If you need more informations please let me know.
> >=20
> > ------------------------------------------------------------------------
> >=20
> > Dec 30 20:12:11 sidney kernel: [31895.552562] Unable to handle kernel N=
ULL pointer dereference at virtual address 00000020
> > Dec 30 20:12:11 sidney kernel: [31895.552699]  printing eip:
> > Dec 30 20:12:11 sidney kernel: [31895.552914] c0136b90
> > Dec 30 20:12:11 sidney kernel: [31895.552933] *pde =3D 00000000
> > Dec 30 20:12:11 sidney kernel: [31895.553014] Oops: 0000 [#1]
> > Dec 30 20:12:11 sidney kernel: [31895.553065] PREEMPT=20
> > Dec 30 20:12:11 sidney kernel: [31895.553147] Modules linked in: sd_mod=
 usb_storage scsi_mod md5 ipv6 lp capi kernelcapi capifs nls_iso8859_15 nls=
_cp437 vfat fat parport_pc parport joydev evdev nvidiafb 8139too mii rivafb=
 crc32 tuner tvaudio msp3400 bttv video_buf firmware_class snd_ens1370 game=
port i2c_algo_bit snd_rawmidi snd_seq_device snd_bt87x v4l2_common btcx_ris=
c tveeprom videodev snd_pcm snd_ak4531_codec snd_timer snd_page_alloc snd s=
oundcore i2c_viapro i2c_core uhci_hcd usbcore ide_cd cdrom
> > Dec 30 20:12:11 sidney kernel: [31895.554927] CPU:    0
> > Dec 30 20:12:11 sidney kernel: [31895.554933] EIP:    0060:[mempool_fre=
e+4/104]    Not tainted VLI
> > Dec 30 20:12:11 sidney kernel: [31895.554942] EFLAGS: 00010282   (2.6.1=
5-rc7.sidney.11)=20
> [snip]
> > Dec 30 20:12:11 sidney kernel: [31895.559540]  [pdflush+31/33] pdflush+=
0x1f/0x21
> > Dec 30 20:12:11 sidney kernel: [31895.559665]  [kthread+110/156] kthrea=
d+0x6e/0x9c
> > Dec 30 20:12:11 sidney kernel: [31895.559797]  [kernel_thread_helper+5/=
11] kernel_thread_helper+0x5/0xb
> > Dec 30 20:12:11 sidney kernel: [31895.559922] Code: 7e 14 00 75 05 e8 4=
6 d2 16 00 89 d8 89 fa e8 8b 32 ff ff 8b 45 dc e9 6f ff ff ff 31 db 8d 65 f=
4 89 d8 5b 5e 5f c9 c3 55 89 e5 57 <56> 8b 7d 08 53 8b 5d 0c 8b 43 10 39 43=
 14 7d 43 89 d8 e8 89 da=20
> mm, strange, could you post .config, gcc version and one more question, w=
hat is
> .sidney.11?

sidney.xx is only an alias for the maschine I build that kernel for and a
number indicating a .config. No patches are included in the kernel.

Please see attached the .config
gcc version is 4.0.2-2 (Debian package version)

Mathias

--gatW/ieO32f1wygP
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config-2.6.15-rc7.sidney.11.gz"
Content-Transfer-Encoding: base64

H4sICBIiuUMAA2NvbmZpZy0yLjYuMTUtcmM3LnNpZG5leS4xMQCMXEuv66qSnvfP2POWEidx
nMEaYIxjdoxhA85jT9BVSy2dwe3b6j4tnfvvu8B5FA8v3cFaCt+Hi6KAonjYVE49P7t7U7td
9fXPf6NL2jBB1CA1c2ZkTDFtPhzk/SSEmD+JmXdbxJ3ZxDSnjhviOkEKhIRSPjDRdHCCPNxA
rswp6vqOflh2BzW4YJMl4welIyOTo1IoPrIP3Gp5YZOTkzMClTBKenEXpieGRPCJW8emK5QP
Objg9mtXoSfIeIX6czl9/fhRgh2ZrUSmu+E6mYe5coWqoaThdyd+zWzG+prOKS0pM8YRSu06
4667SDq1qCqDtGqczx/gItufDB6a2RUMh+p8WX7kSCgsNo4mojfOyFlThmxAqZPKgr1+M9dL
7Qz8QCWTcTQPgfqN0nyyF1QzrGhLDEiZR1SZfrbsjtpfScyaQTCB+gF1ZOTnCZ6aqIVWMV+b
jBtJy8YiIaUq4T9ngfGgpBFQsw8mZDePDFVzAdw8jZJ0GQyGojkpWyNHZpnPpYhG9boAglpD
Gjqwzk2gb44Sk2MdI93IJ5YztP/1ATvWk3m0kYgX9nzg68ff/uvPP/7jj//+25//+J9/vnuB
9xy4f4sL8gCepELd6XCOwTvpuhgZt44SKAcalvf26/Di9A18kfMS4BFolrPU3A7IQi9nAgOS
t5qAETs2kkcs/abcTeqLcfISE3y6jipRro2HcKihVKTLHn5Wrd7HcOg73lG5bWKLGfqPggHm
oKL0YmYR09YgQw6KWQfDi2k8hBgTymaAay9jUpJyRHGagVzmcHBmhexcFkDNWiltz++ziucE
J4z++ntkHgUTwgea5MDP8ag1bPTeCTCpH77zY7/cj8QCAzPCNJMcjwGQ3jG3ZMfuV43g3JUN
jh/0MV/7d0e1WmNNqJ9EkPl/u+1ms8HAlwfelh8ehnu7GUu0/dr85UlEI/2UcCM7E4r6pJG9
vRE/vc5GsamLMhsLLh+EchtPOoQqjmZLSC2zcwkLbtz1JuEI/bRHAFpiLdOPFJ2thaJj8Mo7
JhMMJpwLS5/uSfrocwKTOsHtwDS40wQlYJQE4q1IH5XgKFqSKj4Sehm5se7BiP546UB2LJpy
AsZoAih5wyNusejDWJaMVWinZHCGrPDbEvC3uKa4L0DCdRLCDdLieMXD0D0d71K049CHISaC
mk2XmNLWx1buLGyCM+iWfjAtlXGy71H/ojxKuLMk0yOGWnD5MdJxzXBU4jEhshhiCfS818BZ
KdHIDSgqKCdp2vkJ0VEelRsILqMQxwtrZ5Tt4SNCJK6rj9Xpk+ZNtTlVuDgvAdzFBAPXcjQe
Wj71AiLBEVnriQluUMaJYUtAh8PpeeIoaLn3eDL3KT8H6EiW8yMIBVxYGldOwBwMjsbEKOmu
ZKIwjWsJYRLuhebi+Z63EEabIXqoCAb5CkIT67ukibgg3PU3QfSlQCyPEjt8xy3TevdtFo0s
UqLJ1EnxbZbbv5CnKxYDUXwrDYv0U5NK064baA76uTBHNdEI9E3MFVdxo3N11ixSRwR9YmFc
GOGu2xKIV2sPvwSSFx41ny+FDKgIDzCjEgRWJ37ii0E7T36NFIMdJ+dEvqUqgT0CP/3QwcsI
da1xZa+1Xw5coznRC6wzjetc5bqoc50r7YtJQcjZ8zEaMq3m3ZmVGLD21PvqTLAIopeouTxh
k8Vakt9l4yZiw5rMpHxvVVoO1zSFbCEbgUipIymqVJ5zWX2mpainB0hwQSysy5eFcZHiCgbf
OZO3kIJkui+Eulj7UKtP6czaTyYMZ6lXdIGwoEzA/OVXwEWO0alMdIZmtlsYMiT9EpuKTWc7
rOhnxxWCKmFWdB/YqJguc34WWzHiar9daHmb1oT64LZj15Wqd51ebzkffIgVVWneE592pmt2
hnEuVtvNV3C9p3i2fdi1Du0nwm86tbGaT+eUezqIdDASfQZnqJnfa1khR5kJezLzOlXuFE9y
6ovDeCKZCpNfHzHWJbPwR5QgBmRp0mXS3lV7RoArqjDrl11l0hBRUtKZSSi/pcIzB+HZgs/z
cMHtebjkDj1edomeKblFyHwe10xQ8CxPpuA+nkzJf7xNnvfbJ0VHYgzvH2uK5C7k9eDKeNDk
ttZwsuggIH4pzwVAlIcAEAXz1cXJpl6bbepvphvEJVMKYvTaI1LZtZJ6Tc4r1DCuaVCahHBx
qWuNtI8bCFE+YBkYjMK1Z8mQTDrYYtmsg0g283q/whWcfV32dfW6P8NU7gcxW3BbdXnw1d8M
F8wVminq8Ut8F4ffdDQujbcZY82m2m6RtBfkqH4o625MrZOUim9Ye8ErAKVD8Ac21iLsA7Uz
H5F37m9hQYzN7wc3mBXvoSgYdVEnfAJ+Q7aAQWk9Oqh4EeADoh3cF76tGrSx2Y4XB73E9Wgp
/8L89nmOhnrLMqeJKIJQyxlm+21d4sIBw35zepO001L4QJJ2V6RWBINl+96fX22rMn8L61O0
gLbESVgUOhaNpo7ltlgDO25w2L8Ai9MI+zLFh2jBsAAbanikxmvDuygk2t1Z0s4MvoNx/St/
4jtRfiMnFffEkhOv10OK462PF3rlpKno/V6gFolZCcl5WmQAn8r3Nl8CTcGGeFf6g8Gyf+ok
WurRQS/UOSlsabZxnmKV/HiE2DtawAUcHOPZR44xysN/Yq3G81AALY4RAvJrJJU3GPZYoBun
eH3fzUKgEAHWubGHY35zNdpMEpzHWaLmbba7k5UyzgEhIcdtAUEx9mLLDt2NXNmI93yfOAjw
VIZr8qDRbHyrtptNBsBQmbiV0XL8VlU4J+EaKew3k3FAocZ7hlnRZdgE3o6N+ePQ0VPMnzyM
cZYMCnXMhQXYKHDhehZxFRzNc5bF3sbdYYMmKKW5EQc0sw8SOqVK0+95Bh1nLATYKMvsu0WK
YQ19x7jBcgCiN9Qflw4V9nbTLdwdPTSnrC6AHvcZ2ovrz21zz3BFfV/OupigpZ5nBD1tabzt
G4g7LCsqVbD2PZauVJRYnMDI8Q68h9P9Io8R85ho/LRHIGx/xGjH/MEVi8HWdPHWVihdqTib
REkz4iHpU+E6hIbGweu9QBjhz6piLBwU+F/orJKbDi9pIOWo39SPoU5fHbmKdvvaQ/WLfyOn
WE54EnxP140s7oIf1v+rNoUSw7/e+H3Wce3BHvuSSc14P84noYYzmAIi3BXcKUPm+yprqGZs
cvev7abaf5/n8XWsmzjLT/mIg+uAsmsBvLBHK/1ZyVuTFwLe4NJ2RQ2Re5fheNlUKWRgjidj
WhooZiynqEe/EEcmEoX3H2LXldCOF1AqW00K+LmvLiU4mlki2IkiAxHzyIS0BY5PMCwJLVEG
gowbn6LQ+k3C7EBL4sKtjVXCzaYtWPFJVvhe1ZuEkaC5LOkgyJmNkVP76K4IZVK3a1Trb6YU
OAvxSLm+N95BosB07alkcyIYlSXV7Awe4KxJjzy373c4ePBJx5vNvkpB+B8vZBZ45G3UnX3x
cb4X4iZzODQFfNwXQCbm7eayLTC9aPD0ekW+5Br2V/w9HTSJ3nJsGW2uqQ6bIvjtE9E8i/FJ
uxl8N7q/8GSp1LkoD+bl+KPJU+OUfaBpe7mZsAo+F2TV4b3oCte44n0BAYESmcC/p6giE6cu
vXv2YZ6brDG1RLrLGO4JZYnMaDkURPlDbn/G/XfULOlx4HSNlpzaonEOq6Ai4NCcQM4qSgT1
xhi64tBHxKEv2OccLv08bw18qlDRKAELEXD40eRQ0XDvqY02xJ6gon0JJCnIt4fdoQDWuwJ4
T0HRHQ91CXNm3zRVxjTbaBcFQB6NqwXZbmLErx/3SSaT1GQKTjUpMdsHCaCWhlxJdC4F8IKh
Ygz9C9YUjtA2ycjBpZwOGVjvNhl2qu8JZudE3JWTDFB49RIwKTspE+tDa8Z2MAwGtjauM9vd
7ljGcWT9whmDAkWOQx9qDqUHoOTTYXdaeeK0zQkYNc2hLogS5F43R2TNML621eYQj4DhJvD8
EpL+5lEukXQCArKCDgtxWCPqFWJXFnWq9psCYdpoyfrG7V0V5ECL1CVVe3+zUhdxJU2On8fD
tjGFJgSi2pQIbptCDxkFHvcf9FiwGqBFCcemhDYFowBaLK0pllbW91SUi1d4qKdt622x0zbH
XV2Qk430NyEM3R9FoeEWpt2dCsrCwK6bujBeb83u2GwLXdkTp6pMjMfmYAtdAai6Og79GsNK
1NARvPgNN/pcNNksUGubfZOChpD60GRwe/tF8dS6oLQE3k6nus5yKuwZP5jDa3AE+2A71+xQ
7etMzIKjrmDniWm32+wyLSASgWVMZpvfUuNIHIGunX+XiY7iiS1mdivMKMbd7htK5yKhcsft
br8Cw0RuMnuIe2a6Dh8VLNDA7nwWTmous6o/uTMTfOJZ89zz3sFE1eCdzAWVV+gddOBZC5O5
475HUhkt0F4dtQiHGu/zFl1gd816d/jfzn2Kh96Rde88X2tpViOePWiv6Xzbo1Vi3zoKfz2s
YeOblU+CSvUgmpGM4H592I48fiRs4izXRExEXJlBMp6WCbeuo2wTMHgYvqEwO+Oc/tZWlM8D
xVzpfVsvk0lQHx84XM8kX6iEre0c7iGEZ8txzpv8aCIn65q/GpR9QfAd/FGeZZyCNeY03/1W
c5kA/VIBT4aOs60qfEIWrh6fB1h00s6ZWYWYtECH8/3nMudTgQ//ZD6FgrjyM55JcxtYsOGp
JElAoHs6Oj+QaAFv8c1rjyarFQ8pKmJguHX4XNRDmtwEx9tCHjTs18wmmsoDOD3M8LA0Btbp
+I0fAAW/+wvNxmQq5eC7uEBFYiD4LFTMK/JiXm+/xM+99jnTV5k8l/T2NwT/bTTcPPN6aaWD
gYI3kEMd1bzfbMNyP9avYKQr17mdhVXkmlYt7AvM2/pw2CS5Q3ExBvP/8V6AwsEo9S9TxCpD
eAFLjkQwM9tT3cQYTN6Lj8/h2dwrVLuQUy/3tNxA0eZnxMgBn2FFsYHPlzTKAvnxgk8PPdqS
qbvxDl9l9nD2eoYH2eBPhvB57Rtd3jfhRhae0FJaN8ytszZmuVHbbX3PRcpiQQGFYuzIwPDg
o6dY3Fx8yoywKF+D8a5TMC8e4h7INn3CsxYCFLy+RmDJ8m+KWNKTtkz2msE0L8okN12F38mJ
pHq/VGTgN7FlynSd3pzWucOhzIUXAweZSB14Yl0AkhMJQBx+HcOnFUcdDGYYDv5iiHLZQc/G
CmKgDSLiWUh0uBEakCvLLrEyN0KlSNuZUZLofGktSUZR2GET0VmVh4WVMx1ijNsSys5kJPcY
ezASDtQi8K5SdYiFkeO3+ZPCL+xhFITHJY4oNbKCGqKjDV61B4xTLTNbdaTNfAm4DZLYrzNt
MiZ4K7JcFznBozeaDOPrAW+Shd7FIk8coOkEy4kqHWPXuknq4ddWDd4MDA2XFkqJTZALuUUX
XcJj0F7RO1ge1BZcxSEpFf6ig1OPhfcOYCmwPd5zgnY0XEzImfNYVxuS4/C33aS1DYfNY9ZE
4coCuEQTjq2LpYNLb02qMvREJw41PqkJ8FQdq8TdtGy88CmdjUSICROnr4ycqqZpYtjr8ZvM
OrXv725bpa0vZOrbjTlWm7TXxMd7Hyy/34M4wrXy79MXHyTTw3vpIve0QIm6DeC7BkZske34
2b+BSGH5EW/XojxUVdtsDDypRzjUdqIp0kxAty0yve38sYEsklcevZaIGK7IrzJRzs+683q9
XiQE1OWWgj60YlSubkX85QFVV26ny2jKZV1ky0d/G7/ICv+5AH9oWSLVWO02uyI1qP29SBjS
lzuZJxw4/OheOuJXTEUfLdM/o1vLiPU3PNJp7kn5rxXIso2lmHjmyNjv6GA3QILXiWUAwnvK
S4QLy/AbGZOpTHN5SKefkZ2lDa+cxnAap40sAegjvDybOO7B33S1F57UhHfLXYFYJJIoBI0S
rg1BfgTdWny9jt1tFd3BewLu7i+55fDy3QtCx5wyjM6a20dBFkenbmkaMu1SDXZlDXbrGuzK
GvzE1y0gh2iTa6JlgXyS1t/c/2xlpEDvb2REV1aMPNX1JsJ+ypHjm3u/IROu6ZKOHpm7PktP
I94M8m9PoAzCdDIWcU2z+PTrKxB+x0D5aH+/O5Z4Lv3BpZ9Zf/zxv/9omsPp37eH96vr2Y3N
AFySw+uHwVmsUDgZvkKCkv4jD4kNSJcCfQIMedqHERHWsiRTm6RTni6qfex4T0tRCfBruu8T
yH8oJm7AJMNUSONvwSzpuDsC1kVPdO5a5VlSOV1RULioitYp9IJkh6S77vHY8vNdqjFIfW+N
RYR/0QtHO2aeNN6bXtLujHd5AICR6zF30e2hSBh1Efj0SbRx20XXxyaqXJL24zy84g0RxHmK
bissbHg/PdS/QBqrZY76+k4mRaWpCmj43EwnMzwa2wsE3kzjD7jAkCVxZRfAybGL39EnSd/S
98j2p9gq729TvN9CR9ceglf5fL3is/0JHchfgw/f4EHdqBOl3HHtRvPejvvxf3/+Z/MDMy/H
5Pb4LDxijusMPvGMmAYvdRKmWmXWpa1p0NSr5dTbVWZVA3yumzD7VWZVa3xalzCnFea0W3vm
tGrR026tPqf9WjnNMakPTIl+1nHNygPbarV8oBJTE0Ojy/JI/rYMV2V4V4ZXdD+U4boMH8vw
aUXvFVW2K7psE2UukjdOF7A5xmbboyZYdsrDMQIKisK+ePodtnAy5OdB/KbKKP2HwvrnV6G2
x48Iv6kevqPjXe+Mv/njPzfhX4s2aYlmxLuOC5Z9UumZVfEp3ueO8fTLOwsLf9nnJBaGT/jV
q3CSBfHjsqn6mTKJHh/Z4cKzYAuzkN9+70d5+5D+UzQ99zv8Inx3oefJx6yEUj4sQ+bJYt0X
El7YkPiLBW+GEkVg0QheGr/U8Kb91nb48FxOwY/xOhaJZM8kZZaPaxB/b+9fyOOuZJzZ13Y1
Z8eubMSfTfv/Ns4oh0EQBqBnws1k+8SKg+jcBJyJP9z/FqNOXaF8GZ9NLahApS2TkB8I2XvD
ZLYYPqumuH71+S1/CW9k/t3Og8Z81RyOMw3V3eGzvRZYzZjTUpRgRYP0/rgWFcPLu0T9w4o7
x61yjEUHcemM01zH8ipyjPFNMvl3LgvKIwv1jTcGy+Dw7kDKZb2SXK8F3sO9liv963zIjnNj
uGksa+N4Tib6P2rAIzfQwqVKMAQA45POAJG0AeicOJgm17FGhqNKasxGmYk+rgydwj0z4l2d
LPQ0vp5wWnOL4I7GmR0bmRi0auxEPp2zyKed0NtrVDouYY2pvZhcvPAFQkbtZodUAAA=

--gatW/ieO32f1wygP--

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDuSNOPtJqRGqEpd8RAtO4AJ91ztiQYlxdLLk6ioNyd2e5te/SrgCfUN5T
49XDL6lLJtc8FK4fhq6wrgE=
=e1vN
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
