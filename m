Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423191AbWJYKS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423191AbWJYKS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 06:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423190AbWJYKS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 06:18:58 -0400
Received: from ns2.tasking.nl ([195.193.207.10]:4403 "EHLO ns2.tasking.nl")
	by vger.kernel.org with ESMTP id S1423191AbWJYKS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 06:18:57 -0400
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <1161755164.22582.60.camel@localhost.localdomain>
From: dick.streefland@altium.nl (Dick Streefland)
Subject: Re: What about make mergeconfig ?
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <3d6d.453f3a0f.92d2c@altium.nl>
Date: Wed, 25 Oct 2006 10:18:55 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
| I'm not good enough at make and friends to do that myself without
| spending a lot more time than I have at hand, but I figured it might be
| something doable in a blink for whoever knows Kconfig guts :)
| 
| What about something like:
| 
| make mergeconfig <path_to_file>
| 
| That would merge all entries in the specified file with the
| current .config. By mergeing, that basically means that rule:
| 
| N + N = N
| m + N = m
| Y + N = Y
| m + Y = Y
| 
| (that is, we basically take for each entry max(.config, merge file)

Can't you do that with just a sort command?

  sort .config other.config > new.config

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

