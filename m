Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbTE0TxO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264087AbTE0TxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:53:14 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:34230 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S264082AbTE0TxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:53:13 -0400
Subject: Re: [PATCH] Re: ALSA problems: sound lockup, modules, 2.5.70
From: Stian Jordet <liste@jordet.nu>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030527185104.GB27916@parcelfarce.linux.theplanet.co.uk>
References: <3ED3AC36.5050503@trollprod.org>
	 <20030527185104.GB27916@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1054066050.551.5.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 27 May 2003 22:07:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 27.05.2003 kl. 20.51 skrev viro@parcelfarce.linux.theplanet.co.uk:
> 	Argh.  Missing initialization in char_dev.c - it's definitely
> responsible for crap on unload.  Load side appears to be something else,
> though...

This did not fix my problem. When I unload one ALSA-modules after the
other, the system hangs when I come to the "snd" module. No oops or
panic, it just freezes. Other than that, ALSA works fine for me, just
frustrating when I reboot.

Best regards,
Stian

