Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbUCOO2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 09:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbUCOO2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 09:28:42 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:50614 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S262572AbUCOO2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 09:28:41 -0500
Subject: IDE performance drop in 2.6.4?
From: Tillmann Steinbrecher <t-st@t-st.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1079360942.2076.1.camel@paranoia.pallasnet.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Mar 2004 15:29:02 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have the subjective impression that IDE performance has much decreased
with 2.6.4, as opposed to earlier 2.6 series kernels. 

With 2.6.3 and 2.6.2, I could unpack large files on my HD, copy them
around, etc, without affecting MP3 playback. This is no longer the case
with 2.6.4, MP3 playback frequently stutters when writing much data to
disc. Kernel config is identical. I use cryptoloop (blowfish) so my
performance problems may also have been introduced in the crypto code.

DMA is enabled for the HDs, looking at hdparm output, there seems to be
nothing wrong.

Has anybody else observed the same? Or is ist just a problem on my
system?

Please CC me replies, since I'm not subscribed.

bye,
Till

