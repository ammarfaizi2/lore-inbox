Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933169AbWKMXla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933169AbWKMXla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbWKMXla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:41:30 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:51154 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1752646AbWKMXl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:41:29 -0500
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Romano Giannetti <romano.giannetti@gmail.com>
Subject: Re: pcmcia: patch to fix pccard_store_cis
Date: Tue, 14 Nov 2006 00:40:00 +0100
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611140040.02079.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-01.tornado.cablecom.ch 1378;
	Body=4 Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

please also try this patch on top:
	http://zeus2.kernel.org/git/?p=linux/kernel/git/brodo/pcmcia-fixes-2.6.git;a=commitdiff;h=e6248ff596dd15bce0be4d780c60f173389b11c3

(after you have "[PATCH] pcmcia: start over after CIS override"
	http://zeus2.kernel.org/git/?p=linux/kernel/git/brodo/pcmcia-fixes-2.6.git;a=commitdiff;h=f755c48254ce743a3d4c1fd6b136366c018ee5b2
 applied)

if that doesn't work, i'll have a look at it on the weekend.

rgds
-daniel
