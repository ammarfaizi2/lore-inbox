Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261769AbSIXRuh>; Tue, 24 Sep 2002 13:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261731AbSIXRtS>; Tue, 24 Sep 2002 13:49:18 -0400
Received: from dsl-213-023-039-208.arcor-ip.net ([213.23.39.208]:4284 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261736AbSIXRkL>;
	Tue, 24 Sep 2002 13:40:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Dave Olien <dmo@osdl.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: DAC960 in 2.5.38, with new changes
Date: Tue, 24 Sep 2002 19:45:26 +0200
X-Mailer: KMail [version 1.3.2]
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, axboe@suse.de,
       _deepfire@mail.ru, linux-kernel@vger.kernel.org
References: <20020923120400.A15452@acpi.pdx.osdl.net> <20020923.135447.24672280.davem@redhat.com> <20020924095456.A17658@acpi.pdx.osdl.net>
In-Reply-To: <20020924095456.A17658@acpi.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ttkV-0003id-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 September 2002 18:54, Dave Olien wrote:
> According to the Documentation/DMA-mapping.txt file, the new
> DMA mapping interfaces should allow all PCI transfers to use 32-bit DMA
> addresses. Controllers on the PCI bus should never need to use DAC
> PCI transfers.  Based on this, writel() should work even on ia64.

A totally disgusting idea: MMX/x87 are also capable of transferring 8
bytes in one instruction on ia32.

-- 
Daniel
