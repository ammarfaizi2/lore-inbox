Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265364AbTLHJym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 04:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbTLHJyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 04:54:41 -0500
Received: from imf.math.ku.dk ([130.225.103.32]:3788 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S265367AbTLHJyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 04:54:40 -0500
Date: Mon, 8 Dec 2003 10:54:34 +0100 (CET)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Santiago Garcia Mantinan <manty@manty.net>,
       Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       Michal Jaegermann <michal@harddata.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Synaptics PS/2 driver and 2.6.0-test11
In-Reply-To: <200312071954.31897.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.40.0312081021080.10795-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 7 Dec 2003, Dmitry Torokhov wrote:

> The difference is that GPM (I assume you are using it to get Synaptics
> support) only logs "protocol violations" when in debug mode, and then it
> only checks 2 first bytes.

No, gpm checks the first byte and decide whether to read the following 5
bytes (or trough the byte away). The synaptics driver itself does the same
tests as the kernelcode (and reports an error).

Peter


