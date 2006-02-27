Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWB0O1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWB0O1t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 09:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWB0O1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 09:27:49 -0500
Received: from ns2.tasking.nl ([195.193.207.10]:7866 "EHLO ns2.tasking.nl")
	by vger.kernel.org with ESMTP id S1751256AbWB0O1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 09:27:48 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <43FF88E6.6020603@linux.intel.com>
From: dick.streefland@altium.nl (Dick Streefland)
Subject: Re: [Announce] Intel PRO/Wireless 3945ABG Network Connection
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <698.44030c45.bc404@altium.nl>
Date: Mon, 27 Feb 2006 14:27:17 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Ketrenos <jketreno@linux.intel.com> wrote:
| As a result of this change, some of the capabilities currently required
| to be provided on the host include enforcement of regulatory limits for
| the radio transmitter (radio calibration, transmit power, valid
| channels, 802.11h, etc.)  In order to meet the requirements of all
| geographies into which our adapters ship (over 100 countries) we have
| placed the regulatory enforcement logic into a user space daemon that
| we provide as a binary under the same license agreement as the
| microcode.  We provide that binary pre-compiled as both a 32-bit and
| 64-bit application.  The daemon utilizes a sysfs interface exposed by
| the driver in order to communicate with the hardware and configure the
| required regulatory parameters.

I fail to see how a binary-only daemon can be used to enforce
regulatory limits. What stops a user from running a daemon for
another country, enforcing different limits?

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

