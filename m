Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267700AbUJLTyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbUJLTyM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 15:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267702AbUJLTyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 15:54:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61617 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267700AbUJLTyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 15:54:08 -0400
Date: Tue, 12 Oct 2004 21:55:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: linux-kernel@vger.kernel.org, "K.R. Foley" <kr@cybsft.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T6
Message-ID: <20041012195526.GB3961@elte.hu>
References: <OFBECDA4CA.06BA3FF5-ON86256F2B.005609F8@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFBECDA4CA.06BA3FF5-ON86256F2B.005609F8@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> >i've uploaded -T7:

> This crashes at boot time again. Several more scrolling messages that
> end with (all I can see on the screen)

could you try to capture the full bootlog of the -T8 kernel (which i've
just released)? The reason is that often the crash you get is just a
side-effect of a problem that was warned about in one of the 'scolling
by' messages. In particular the scheduler crash you got seems to be of
that vintage.

	Ingo
