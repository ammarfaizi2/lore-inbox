Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUI0Us1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUI0Us1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267356AbUI0Uru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:47:50 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:51434 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267345AbUI0UoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:44:17 -0400
Date: Mon, 27 Sep 2004 22:45:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Gene Heskett <gene.heskett@verizon.net>,
       Matt Heler <lkml@lpbproductions.com>
Subject: Re: 2.6.9-rc2-mm4
Message-ID: <20040927204557.GA22542@elte.hu>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409270053.22911.gene.heskett@verizon.net> <20040927201928.GB19257@elte.hu> <1096317273.2523.5.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096317273.2523.5.camel@deimos.microgate.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Fulghum <paulkf@microgate.com> wrote:

> I'm seeing the exact same thing at the same point.
> Removing pre-emptable bkl option allows boot.
> .config is attached

great - i can reproduce the hang with your .config:

 Intel machine check reporting enabled on CPU#0.
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
 <hang>

Investigating.

	Ingo
