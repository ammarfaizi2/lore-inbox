Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVB0RyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVB0RyP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 12:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVB0RxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:53:10 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:5132 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261457AbVB0RsP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:48:15 -0500
Date: Sun, 27 Feb 2005 18:48:37 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: Re: [RFT] Preliminary w83627ehf hardware monitoring driver
Message-Id: <20050227184837.2563a454.khali@linux-fr.org>
In-Reply-To: <20050227131027.GM25818@edu.joroinen.fi>
References: <20050226191142.6288b2ef.khali@linux-fr.org>
	<20050227131027.GM25818@edu.joroinen.fi>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pasi,

> Do you know about driver for W83627THF watchdog? I'm using Supermicro
> P8SCI motherboard, and I haven't found working driver for it..

Have you tried w83627hf_wdt? I took a quick look at the W83627HF and
W83627THF datasheets and watchdog timer seems to work identically. Since
the driver doesn't seem to identify the chip (it probably should, BTW),
I'd expect it to work.

Hope that helps,
-- 
Jean Delvare
