Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290987AbSBRTZL>; Mon, 18 Feb 2002 14:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291106AbSBRTUO>; Mon, 18 Feb 2002 14:20:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13319 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284144AbSBRTT0>; Mon, 18 Feb 2002 14:19:26 -0500
Subject: Re: Missed jiffies
To: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 18 Feb 2002 19:33:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a4pbvi$iq2$1@cesium.transmeta.com> from "H. Peter Anvin" at Feb 17, 2002 02:48:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ctXa-0006Yc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the TSC is affected by HLT, throttling, or C2 power management, the
> TSC is broken (as it is on Cyrix chips, for example.)  The TSC usually
> *is* affected by C3 power management, but the OS should be aware of
> C3.

ACPI is irrelevant to the machines in question. This is all APM era stuff
and yes some people change the base clock, not stpclk. The cyrix hlt is
already handled
