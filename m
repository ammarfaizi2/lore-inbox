Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVF0TG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVF0TG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVF0TGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:06:46 -0400
Received: from [212.76.80.29] ([212.76.80.29]:3589 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261633AbVF0TF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:05:27 -0400
Message-Id: <200506271905.WAA07210@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: increased translation cache footprint in v2.6
Date: Mon, 27 Jun 2005 22:04:58 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcV6omsYOlmw5r2eQ5WlL9DpcjJ7rQAhO15QAAiJGdA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> We've noticed a slowdown while moving from v2.4 to v2.6 on a small PPC 
> platform (855T CPU running at 48Mhz, containing pair of separate I/D 
> TLB caches with
> 32 entries each), with a relatively recent kernel (v2.6.11).
> 
> Test in question is a "dd" copying 16MB from /dev/zero to RAMDISK. 
> 
> Which is about 16% of 48000000, the total number of cycles this CPU
performs on one second.

Testing with hdparm -tT /dev/hda shows an 18% slowdown on a PII-400Mhz using
2.4.31/2.6.11.

WHAT'S going on?

