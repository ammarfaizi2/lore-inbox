Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVBULP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVBULP6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 06:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVBULP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 06:15:58 -0500
Received: from dwdmx2.dwd.de ([141.38.3.197]:51305 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S261949AbVBULPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 06:15:49 -0500
Date: Mon, 21 Feb 2005 11:15:37 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: minyard@mvista.com
Subject: [PATCH/RFC] IPMI watchdog more verbose
Message-ID: <Pine.LNX.4.61.0502211106390.15899@praktifix.dwd.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="646811178-144196284-1108984537=:15899"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--646811178-144196284-1108984537=:15899
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hello

This makes IPMI watchdog more verbose during initialization. It prints the
values of timeout and if nowayout is set or not. Currently there is no way
to see what these values are, onced initialzed.

Please check if this is the correct place to put the printk.

Holger
--646811178-144196284-1108984537=:15899
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ipmi_watchdog_verbose.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0502211115370.15899@praktifix.dwd.de>
Content-Description: 
Content-Disposition: attachment; filename="ipmi_watchdog_verbose.patch"

LS0tIGxpbnV4LTIuNi4xMC9kcml2ZXJzL2NoYXIvaXBtaS9pcG1pX3dhdGNo
ZG9nLmMub3JpZ2luYWwJMjAwNS0wMi0yMSAxMDowMjozOC4yODkzNDQ1Mzgg
KzAwMDANCisrKyBsaW51eC0yLjYuMTAvZHJpdmVycy9jaGFyL2lwbWkvaXBt
aV93YXRjaGRvZy5jCTIwMDUtMDItMjEgMTA6MTA6MzguOTI1ODcyOTc2ICsw
MDAwDQpAQCAtOTQ0LDkgKzk0NCw2IEBADQogew0KIAlpbnQgcnY7DQogDQot
CXByaW50ayhLRVJOX0lORk8gUEZYICJkcml2ZXIgdmVyc2lvbiAiDQotCSAg
ICAgICBJUE1JX1dBVENIRE9HX1ZFUlNJT04gIlxuIik7DQotDQogCWlmIChz
dHJjbXAoYWN0aW9uLCAicmVzZXQiKSA9PSAwKSB7DQogCQlhY3Rpb25fdmFs
ID0gV0RPR19USU1FT1VUX1JFU0VUOw0KIAl9IGVsc2UgaWYgKHN0cmNtcChh
Y3Rpb24sICJub25lIikgPT0gMCkgew0KQEAgLTEwMzEsNiArMTAyOCw5IEBA
DQogCXJlZ2lzdGVyX3JlYm9vdF9ub3RpZmllcigmd2RvZ19yZWJvb3Rfbm90
aWZpZXIpOw0KIAlub3RpZmllcl9jaGFpbl9yZWdpc3RlcigmcGFuaWNfbm90
aWZpZXJfbGlzdCwgJndkb2dfcGFuaWNfbm90aWZpZXIpOw0KIA0KKwlwcmlu
dGsoS0VSTl9JTkZPIFBGWCAiaW5pdGlhbGl6ZWQgKCVzKS4gdGltZW91dD0l
ZCBzZWMgKG5vd2F5b3V0PSVkKVxuIiwNCisJICAgICAgIElQTUlfV0FUQ0hE
T0dfVkVSU0lPTiwgdGltZW91dCwgbm93YXlvdXQpOw0KKw0KIAlyZXR1cm4g
MDsNCiB9DQogDQo=

--646811178-144196284-1108984537=:15899--
