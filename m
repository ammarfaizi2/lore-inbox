Return-Path: <linux-kernel-owner+w=401wt.eu-S1751037AbXAOQqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbXAOQqs (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 11:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbXAOQqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 11:46:48 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:55518 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbXAOQqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 11:46:47 -0500
Date: Mon, 15 Jan 2007 17:43:16 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Roland Dreier <roland@love-shack.home.digitalvampire.org>
cc: sfrench@us.ibm.com, linux-kernel@vger.kernel.org, jra@samba.org
Subject: Re: [PATCH][CIFS] Convert new lock_sem to a mutex
In-Reply-To: <87zmdi54sx.fsf@love-shack.home.digitalvampire.org>
Message-ID: <Pine.LNX.4.61.0701151740560.23841@yvahk01.tjqt.qr>
References: <87zmdi54sx.fsf@love-shack.home.digitalvampire.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sep 2 2006 14:36, Roland Dreier wrote:

>Date: Sat, 02 Sep 2006 14:36:46 -0700
>From: Roland Dreier <roland@love-shack.home.digitalvampire.org>
>To: sfrench@us.ibm.com
>Cc: linux-kernel@vger.kernel.org, jra@samba.org
>Subject: [PATCH][CIFS] Convert new lock_sem to a mutex

A bit dated, however...

since 2.6.20-rc5 still happens to use lock_sem, I tried
this patch (in 2.6.18). Works fine, nothing seemed to
break.


	-`J'
-- 
