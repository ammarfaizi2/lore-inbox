Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbUK2SDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbUK2SDj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 13:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUK2SDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 13:03:39 -0500
Received: from mail.nea-fast.com ([66.35.146.201]:34022 "EHLO
	int1.nea-fast.com") by vger.kernel.org with ESMTP id S261447AbUK2SDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 13:03:31 -0500
Message-ID: <41AB6476.8060405@nea-fast.com>
Date: Mon, 29 Nov 2004 13:03:34 -0500
From: kernel <kernel@nea-fast.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040602
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.9 tcp problems
Content-Type: multipart/mixed;
 boundary="------------010402040202050206090202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010402040202050206090202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've run into a problem with 2.6.(8.1,9) after installing a secondary 
firewall. When I try to pull data through the original firewall (mail, 
http, ssh), it stops after approx. 260k. Running ethereal tells me "A 
segment before the frame was lost" followed by a bunch of  "This is a 
TCP duplicate ack" when using ssh. All 2.4.x machines and windows 
clients work fine. I built 2.4.28 and it works fine from my machine. I 
also fiddled with tcp_ecn and that didn't fix it either. I don't have 
any problems communicating to "local" machines. I've attached the 
tcpdump output from an scp attempt. NIC is a 3Com Corporation 3c905B.

Thanks !
walt


--------------010402040202050206090202
Content-Type: application/x-gzip;
 name="dump.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dump.txt.gz"

H4sICChjq0EAA2R1bXAudHh0ALWZQWskNxCF7/kVfRyTbKOqkkolsexeQs4m5BZyGNYbYhKP
zXog+fkpqafdya5boxKYGYNhjPXpPVX1Kw1gDjGHMKMgcJj+Pv51nk+fj+9+Pz6f50+PDzOh
cJw+TODm5Y1ufn7+I0+3E4gPwpyi5OXXCIgH8P5mOn76Uz8mD8F51H97f5qQIk7vT49PP5Sf
8/3D5+fz8eFpAnK6eJpSjOSAJHyYDj/+dPMdbGgUEr2KFqNXtPvTGf7/yd3jw/H+lKcJGCh8
P93+8vPHCdcd6Pv+9O54d/dlPn55Os7TwePN14sqjk9f71oX21Go6pGJDoSX3Xtft51ienXb
dbuIzq0CfLNt1RXA4shcFya6Lreyvaz/7briWIwnwfuMTg58sb6LIewzkOOAYlOfKAscvCwE
StMlP6wwryCwN8l/WxbNKHIQt0AIXJch0MayMEy/nh+fJ/eP/Db9BwcSebIpIpAB0yaJ9EmC
K1gbxztvVEdEC4RfeJTtujzMG1eLhzyzM5YrpowYDonXQ8td+viVrMUTXErRpo+un0n85ldP
49RFXrhaPNGhN+kzl/UzcKTS0S9IitclEa9wTSTBaDrR81RwMgHCGzKlNNBzFalCkKDb8yrh
1vGaZydx8qbmN1eA7AOnAWHSStdg8i44MJ6fgpPZQXxDJv96LmiaVZAqREB9zu2ZFXCDaUHo
H0e2CVMAcvQc3koYpIDGyio4WRIMVDvgqtgVJm3QZrMKUoXQcMm7ZkXXZxZBkGgTpgBkcMQD
PadPGa13q1uVJwOIGyj4bioa6ISVqVIIsN81THijaVH4GJ3RsEqQgTAMNB49bJcD1aIKIQZj
zVeeDD66garvptKgYHesMC0UDHtBg5zDjaZFwSSERm0KgUYNCCPdp0ubCJLMWUN5MkTt1gNU
YT3nbarkTCHx4lhhqhQAjvfyhg7T0mdZ1KhqLbKCkBXfjzSgLnEkJjGOgJVHB1GfRkq/j0qc
GxjKK9NiGQa3lzr0FTacFkZiF40RsSJk1MFtpAPFtQs0qDSOARoPUuXJSJRGar+XaiQmVqbF
MkphL3uQC7DhtDA0oSfjQ6MiZPTiR1pQlzg6VpOxyipPRtZZaoBK1t50hSqYrqAulhWmxbJQ
rif2LOPYZxkKOWuVFYSM+t9HWlCXOMT6MlIVnowJZKT2e6niQF6sTItlrGvtWia04bQwdEz1
3ihOQch6KmigBaFbG3eTSupNo2miLzyZ0MlA7XdTwUCVVabrloELG04Lg7VkrOIUhEw65g60
oD5xoic05tjKk0kfswO1j7A+Tq5Q0UBirEwdliH0WSboS1wyiVMQMrHHgRaE2COOpr9grP3K
kynKyDVnNxWPWFaYOiyjuOE0MSTYvj+YF4SsEWTkvhVpfdY2qNhxSNaDVHiyd3HksrOXqkzC
ZssqU4dl21c+2JrLGPTgmMS5XRCyL8HmrcRBjNZQVHmyJx658sSwJoArVGj6PupiWWHqsIxT
n2WkY5n1mrwgZB9g5O61TxwSoddr/18FoO0mACAAAA==
--------------010402040202050206090202--

