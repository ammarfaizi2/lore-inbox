Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752993AbWKFMs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbWKFMs3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753000AbWKFMs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:48:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3599 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752993AbWKFMs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:48:27 -0500
Date: Mon, 6 Nov 2006 13:48:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Carsten Otte <cotte@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>, schwidefsky@de.ibm.com,
       linux390@de.ibm.com, Andrew de Quincey <adq_dvb@lidskialf.net>,
       Trent Piepho <xyzzy@speakeasy.org>, mchehab@infradead.org,
       v4l-dvb-maintainer@linuxtv.org
Subject: 2.6.19-rc4: known regressions with patches (v2)
Message-ID: <20061106124828.GL5778@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both of the patches below were already available when 2.6.19-rc4 was 
released.

The DVB patch was was sent as part of a DVB update Linus didn't pull for 
unknown reasons.

The s390 patch seems to await being forwarded by the s390 maintainers.


This email lists some known regressions in 2.6.19-rc4 compared to 2.6.18
with patches available.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : s390: DCSS support breakage
References : http://lkml.org/lkml/2006/10/27/89
Submitter  : Carsten Otte <cotte@de.ibm.com>
Caused-By  : Heiko Carstens <heiko.carstens@de.ibm.com>
             commit 7676bef9c183fd573822cac9992927ef596d584c
Handled-By : Heiko Carstens <heiko.carstens@de.ibm.com>
Patch      : http://lkml.org/lkml/2006/10/27/89
Status     : patch to revert the commit available


Subject    : DVB frontend selection causes compile errors
References : http://lkml.org/lkml/2006/10/8/244
Submitter  : Adrian Bunk <bunk@stusta.de>
Caused-By  : "Andrew de Quincey" <adq_dvb@lidskialf.net>
             commit 176ac9da4f09820a43fd48f0e74b1486fc3603ba
Handled-By : Trent Piepho <xyzzy@speakeasy.org>
Patch      : http://lkml.org/lkml/2006/10/14/157
Status     : patch available

