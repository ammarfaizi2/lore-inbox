Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbUBCNe4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 08:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUBCNe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 08:34:56 -0500
Received: from mail.scs.ch ([212.254.229.5]:4553 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id S266001AbUBCNez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 08:34:55 -0500
Subject: Re: [PATCH] es1371.c - 8 bit stereo (kernel version 2.4.24)
From: Thomas Sailer <sailer@scs.ch>
To: bnelson@onairusa.com
Cc: sailer@ife.ee.ethz.ch, linux-kernel@vger.kernel.org,
       Pete Cervasio <pcervasio@onairusa.com>
In-Reply-To: <200402030057.i130v763003677@host21.onairusa.com>
References: <200402030057.i130v763003677@host21.onairusa.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: SCS
Message-Id: <1075815283.23177.157.camel@kronenbourg.scs.ch>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 03 Feb 2004 14:34:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-03 at 01:57, Bob Nelson wrote:

> Although the code in the ``es1371.c'' source is not lavishly commented,

That's because the hardware itself is not very well documented. I'm
having serious trouble understanding what the P2_ENDINC bits should do.

> it appears that the intent of the author is to use 1 as the operand
> of the shift for 8-bit audio. However, the original code does not take
> into account ``SCTRL_P2SMB'', 8-bit stereo. The patch results in 1 being
> used as the operand for any 8-bit audio file, stereo or mono.

Have you also tried 16bit mono and stereo with your patch? does that
still work?

Tom

