Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288717AbSANDAQ>; Sun, 13 Jan 2002 22:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288716AbSANDAH>; Sun, 13 Jan 2002 22:00:07 -0500
Received: from codepoet.org ([166.70.14.212]:10673 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S288697AbSANC7u>;
	Sun, 13 Jan 2002 21:59:50 -0500
Date: Sun, 13 Jan 2002 19:59:51 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: radeonfb fix
Message-ID: <20020114025951.GA17592@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0201101827100.22287-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0201101827100.22287-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu Jan 10, 2002 at 06:30:07PM -0200, Marcelo Tosatti wrote:
> 
> Hi, 
> 
> So here it goes pre3.

Hi Marcelo,

This patch is needed to make radeonfb compile and work.
It is based on an earlier patch on the list attributed to
Ani Joshi, plus adds the needed devinit fix.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

--ew6BAiZeqk4r7MaW
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="radeonfb.patch.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWYkHPTQACpx/gHo0n7/cf//+f///9L///2ZgCh327NfTw3c3z3PR9V9AAAMj
QKABDQKaFNNAAaGmg0NpGnqA9QyZAAGgGIAADRA1Ke0jNFNNAAAAAAAAAA0AAADUmntUU0Ym
hkwJpo0MTQxMBDRkNGg0aaNAMAQM1KSaaAaAAAaAaAAaAAAAAAA0CKUFE8U0bKPTU9CaYTTT
1HpGABMjRkejQEMnqZHqYCCKQQAgaCJinqPU0Q9RiBpkyaaaaADTCG1Gm0j0JfddypibkGO1
GNIZDaT4tfZ3yhow41Z8uUFCFsybrycRhLh72d0GU6zE/MEKbIA8kR/b5vMMpSHOtib5vxx1
TqSTBM1zSSdLkxXhKUGj85Aq0wjzPo6/RieM31XSMrVlnEyVgC1KoB0HR1A3iiErmFdmHnOc
D7EJaMXE/fHDCzSCLA1PoHeOyw7B7duA0M8Je/ScdPM1gkkSAHyBBEBDBAQwwqnHjf0iJTiU
UFITTIgBnICvTHDX4w9Nn9TODqBM6lEGgOkaRHKUA+lpbNNhEJEJHsETiU5JMF4gD1CfUMeY
fqSqpGKpgjiGTJhS70RVH0q0gnC4lBPYkJdToTwTxpkkJYn1J6gHEfiNSIgohB8UOowaj+RC
RhumyIpOgdIH7w4SYsuygWIQ5uMGz15UtOa3ziQZCIGnnJigTrmkURAhF2JShgCQfYk1ClZi
c/sxNQxR2jYKW32AADopjoTwAACclEBC0gAAAr0o0i7kVbMpxEyaLJnZtne1LYkgTBpAMbAQ
xjaKyISwUkEiFgYQftBxRatSD9wChAyRnwDmGTf4EU+jmK6oa6FBWiouN9QsENuA1tiEQxgG
AFMBMrR9wVYk5Kd69wEAMAQjJEgQ+T1sbjp7nwjoHHZqMukuUulOY87Jc7GvVdPYO88AIgCA
NVT5khBsp1poAhTSZWZJUkBKySpZScSYAyb4GwAAgAVoAMO9TV120REQklEOVhpohbLY3Zq0
acNNrWtERwyyySSSSSSSdEAMBShMUobTtQYAJKcAAAAAAAopNogACGsJqJAUEEekn+knPYCn
cpnDrG3x+hWnrjOS6HaM60Ut19D2/D01sUt1GIQthhCCdBhCTCEJAcDjU2QExVqqwmA0uOx2
appZQ7NopK6WoQdkMB4MtgU+eH59I2GP4SVTf2dg1AZVPVHyWd/ZBIqJD2z7adbE5SPIEoSc
5sKlvdM+XLZih8KfAnvXmBG9D4pg0g0Qh0hyH3MQzEwDW0Z2+N9TKY4oerz4kUks1NciI0AO
Y01uXgnhUlOFAESpTNepGjCA8IJThLtcICpWkvJfKCtayJSp7uoZJaUI29tLIiom7L60Pe4E
8kMqZKhURFMIBGuPGORsslUC2MhUWk7VLhOTLUkO/Gy7fvoN8IU/OloyGeA774AheEvt/oo1
VHwj80zktJxis6u0ru5CG+2+YCucxHgoKeSb5mtCHzHrELcTgcJEWU85anz2DZ68zTE8oHay
fPCHi2y4Dj2OS3kyCqewJQ/XBpQ3RB9PxyJaUFM6yOcQD/eAyc2PjMic5SIkQRMnSyBgChkS
ZFPuAcqCaOFx1F0g0GsIRBBBBtMQyxSwbuqMzQfZInpobWZGGjAyNCwHqbC8wJYdSYHWTKsc
BxCbJwuA5DKuOMou7L3g+iNRMLxknAlFpxN/n3NjOic1S7OC+w0ORKZAQbSyw5pTU5nQ5bze
PPLuyKgdRsckNocNssjBKUClFvzhggXpoKZmLUw1GHXECK7GEKWkGNjoD1QNxRDCIbQlKIAt
HKAsTMYNCaSfrAsTrIDnBL+IESgtqdZm4pvkkbRC4uIYKQcjqSNvO2A2uykpRK8JHIjoS5AS
SIM+JacRmZcezB13lCfFhjaSInYBPHd0t27d8zr5WHMeJKMzLgRlBIZczBlBSbAW1bm6sJXj
FwsyiMBbYF3GUZqY33wl2yI4EyB6zK9uhhqW7Cs0ieYVSgHMrQGowciFM1P8Ibc40L7icGVe
YFCU1ijIZDhs4GlMyCghsGgHMcHcWU4UIKyxiKwBpM28+BeNHUNnFppJQ3s0kWkm06kwGBJ5
7S4AiwTChlCWaJlhNLc/kMcL+uscDjBO4ci21NzVvtnZKdlC+DDFNOzdXRMSITgkaHB4zApy
mJFHVYj41xM/AsKBRGwWD0jCFAhNITL3GmpQmVGuOcRtApB8sxWRhJlAzDny3G6pGEWbqFnc
braFL/sbgK1GpKBrUjtLDC6VqbU39OGIdPyhL2j3YPlHmWL9HjFP+APglic0onx/Yh4DehZV
ISo5Jkk6+I7T3kLIUE+TBCPoS+JLo9x6qOaS7AxNTS9BCEuBRSolfNGxJAhSPb2id3IS5Nmg
yGE8RSaT3Jw+xBCqg5CndaPsgZD5QU3Z9E4Jagh3dg/bxifgPePUl8JCCENsHtDNBDuB7wIS
8FMkwGs6Z6jID4YJ9+0XyghAampHL0QlMicwlMnKYRMicwkYDePYkSAx88hnOo1QQsAfRVmw
JgmmopY3ieIBuDROCWLaShVSgJYpKDgD5hgWdJ0qD6xTTGsk0EPfTwS1AexLh2pkKYPeh3J1
2ApPcmOCZANDkPITrBTakkuTpkPWk4Syo3bwD06WpcWpKqWoWISBDakLiKc4UolRhLhmghUQ
hMxO9KnGqBVLUJSQHxIh2KwA3qDr6WnRM04KTSAQsCGBC9JCUbUyTglpYPoaQEk9VJpqJVOE
kyBOicAOYeaA6QRlqF5rG9OiYJonBOKcjC44CnFE7QUsHegN6mIh9NgYQnwJYpUZ5ApVLR1T
gnQeSVE0ZJ4k1B4D11QhISEsJalFZpDRMfEkxL0gaiTTdMexOPrIdEsTEvA2pggNDMFOPWVO
sIBSBTVAfURD+UJEBZzHGE7q6UR/4u5IpwoSESDnpoA=

--ew6BAiZeqk4r7MaW--
