Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbVHZT3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbVHZT3R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbVHZT3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:29:17 -0400
Received: from peabody.ximian.com ([130.57.169.10]:22718 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1030220AbVHZT3Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:29:16 -0400
Subject: Re: [patch] IBM HDAPS accelerometer driver.
From: Robert Love <rml@novell.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, Brian Gerst <bgerst@didntduck.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1125086134.14080.13.camel@localhost.localdomain>
References: <1125069494.18155.27.camel@betsy>
	 <430F5257.4010700@didntduck.org>  <1125077594.18155.52.camel@betsy>
	 <1125079311.4294.10.camel@laptopd505.fenrus.org>
	 <1125079430.18155.64.camel@betsy>
	 <1125086134.14080.13.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 15:29:15 -0400
Message-Id: <1125084555.18155.89.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 20:55 +0100, Alan Cox wrote:

> I think that should be fixed before its merged.

Let me be clear, it has an init routine that effectively probes for the
device.

It just lacks a simple quick non-invasive check.

The driver will definitely fail to load on a laptop without the
requisite hardware.

	Robert Love


