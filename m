Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbVHPMtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbVHPMtt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 08:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbVHPMtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 08:49:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:58278 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S965200AbVHPMts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 08:49:48 -0400
Date: Tue, 16 Aug 2005 14:50:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: Mr Machine <machinehasnoagenda@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: error compiling 2.6.13.rc6 with realtime-preempt patch -rt2 ('quirk_via_irq')
Message-ID: <20050816125001.GA26148@elte.hu>
References: <4301D0F9.4050405@gmail.com> <200508161402.57051.Serge.Noiraud@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200508161402.57051.Serge.Noiraud@bull.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> mardi 16 Août 2005 13:41, Mr Machine wrote/a écrit :
> > i get this error during compile of pci drivers:

> I have the same problem with rt1 and rt2.

i have fixed this in -rt4 (just uploaded).

> One 'bizarre' thing : If I patch directly 2.6.13.rc6 with the RT 
> patch, I have an error on this driver with the first patch at 500 
> instead of 560! Did we miss something ?

yeah, patch management mistake. (My repository had the full patch but 
quilt didnt pick it up because i edited the file outside-of-quilt.)

	Ingo
