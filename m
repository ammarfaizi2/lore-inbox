Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269799AbUJGLnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269799AbUJGLnU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 07:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269802AbUJGLnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 07:43:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:35032 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269799AbUJGLnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 07:43:19 -0400
Date: Thu, 7 Oct 2004 13:44:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Hanno Meyer-Thurow <h.mth@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
Message-ID: <20041007114434.GA21937@elte.hu>
References: <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <20041007105230.GA17411@elte.hu> <20041007134116.3e53b239.h.mth@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007134116.3e53b239.h.mth@web.de>
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


* Hanno Meyer-Thurow <h.mth@web.de> wrote:

> > i've released the -T3 VP patch:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3
> 
> i get this on compile:
> 
> init/built-in.o(.text+0x18b): In function `rest_init':
> : undefined reference to `sub_preempt_count'

ok, this happens if PREEMPT_TIMING is not enabled. I've re-uploaded the
new -T3 patch, please re-download it.

	Ingo
