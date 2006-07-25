Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWGYSc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWGYSc6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWGYSc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:32:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46310 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751471AbWGYSc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:32:57 -0400
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
From: Arjan van de Ven <arjan@infradead.org>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <20060725182208.GD4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net>
	 <1153850139.8932.40.camel@laptopd505.fenrus.org>
	 <20060725182208.GD4608@hmsreliant.homelinux.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 25 Jul 2006 20:32:55 +0200
Message-Id: <1153852375.8932.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 3) this will negate the power gain you get for tickless kernels, since
> > now they need to start ticking again ;( )
> > 
> That is true, but only in the case where someone opens up /dev/rtc, and if they
> open that driver and send it a UIE or PIE ioctl, it will start ticking
> regardless of this patch (or that is at least my impression).

but.. if that's X like you said.. then it's basically "always"...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

