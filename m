Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbTENOCZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTENOCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:02:02 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:47885 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262320AbTENOB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:01:26 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: hdb: dma_timer_expiry: dma status == 0x64 [2.5.69]
Date: Wed, 14 May 2003 14:14:13 +0000 (UTC)
Organization: Cistron
Message-ID: <b9tivl$2em$1@news.cistron.nl>
References: <Pine.LNX.4.51.0305132143570.19932@dns.toxicfilms.tv> <20030514134704.GA1062@babylon.d2dc.net>
X-Trace: ncc1701.cistron.net 1052921653 2518 62.216.30.38 (14 May 2003 14:14:13 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zephaniah E. Hull <warp@babylon.d2dc.net> wrote:
>Happens only with heavy disk IO, running 2.5.69-mm3, happened with a few
>earlier kernels and sadly I don't remember which kernel it started on.

I had similar problems on a uni-processor machine.

Try this:

Disable IO-APIC in the kernel

EG:
 Processor type and features ->
[*] Local APIC support on uniprocessors
[ ] IO-APIC support on uniprocessors

This way i don't experience these errors anymore.
I can only guess what causes these errors.

Danny
-- 
Miguel   | "I can't tell if I have worked all my life or if
de Icaza |  I have never worked a single day of my life,"

