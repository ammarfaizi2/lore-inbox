Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270624AbTGZWqr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 18:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270629AbTGZWqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 18:46:46 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:4480 "EHLO hades.pp.htv.fi")
	by vger.kernel.org with ESMTP id S270624AbTGZWqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 18:46:38 -0400
Subject: Re: 2.6.0-test1: irq18 nobody cared! on Intel D865PERL motherboard
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200307262313.08819.adq_dvb@lidskialf.net>
References: <20030714131240.21759.qmail@linuxmail.org>
	 <1059256372.8484.9.camel@hades>  <200307262313.08819.adq_dvb@lidskialf.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059260505.1119.6.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 27 Jul 2003 02:01:45 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-27 at 01:13, Andrew de Quincey wrote:
> Out of interest, do these boxes have an IO-APIC and are you using ACPI? If so, 
> can you tell me if the attached patch helps?

Yes, yes, nope. I tried your patch but the SATA driver now hangs during
boot waiting for an irq that never arrives.

	MikaL

