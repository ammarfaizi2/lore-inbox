Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVAQW7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVAQW7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbVAQW5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:57:41 -0500
Received: from er-systems.de ([217.172.180.163]:42372 "EHLO er-systems.de")
	by vger.kernel.org with ESMTP id S261535AbVAQWxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:53:36 -0500
Date: Mon, 17 Jan 2005 23:54:03 +0100 (CET)
From: Thomas Voegtle <tv@lio96.de>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
       jgarzik@pobox.com
Subject: Re: [patch 2.4.29-rc1] i810_audio: offset LVI from CIV to avoid
 stalled start
In-Reply-To: <20050117184609.GE4348@tuxdriver.com>
Message-ID: <Pine.LNX.4.58.0501172347230.22798@er-systems.de>
References: <20050117183708.GD4348@tuxdriver.com> <20050117184609.GE4348@tuxdriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2005, John W. Linville wrote:

> Offset LVI past CIV when starting DAC/ADC in order to prevent
> stalled start.
> ---
> Here is the (working) patch I'm using against a later 2.4.  This makes
> sound work fine with Enemy Territory.
> 

This patch, hand-modified for 2.6.10 enabled sound again with i810 and 
quake3. (Q3 1.32b linux-i386 Nov 14 2002)

The problem was that in the opening of quake3 sound was there and then 
suddenly the sound stopped. 

Thank you John for tracking down this problem.


       Thomas

-- 
 Thomas Vögtle    email: thomas@voegtle-clan.de
 ----- http://www.voegtle-clan.de/thomas ------
