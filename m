Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWGYTIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWGYTIR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWGYTIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:08:17 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:10248 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S964836AbWGYTIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:08:15 -0400
Date: Tue, 25 Jul 2006 15:07:48 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Neil Horman <nhorman@tuxdriver.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060725190743.GB31334@tuxdriver.com>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <1153850139.8932.40.camel@laptopd505.fenrus.org> <20060725182208.GD4608@hmsreliant.homelinux.net> <1153852375.8932.41.camel@laptopd505.fenrus.org> <20060725184328.GF4608@hmsreliant.homelinux.net> <1153853596.8932.44.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153853596.8932.44.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 08:53:16PM +0200, Arjan van de Ven wrote:
> On Tue, 2006-07-25 at 14:43 -0400, Neil Horman wrote:

> > alternative, which, as I mentioned before I would be happy to take a crack at,
> > if you would elaborate on your idea a little more.
> 
> well the idea that has been tossed about a few times is using a vsyscall
> function that either calls into the kernel, or directly uses the hpet
> page (which can be user mapped) to get time information that way... 
> or even would use rdtsc in a way the kernel knows is safe (eg corrected
> for the local cpu's speed and offset etc etc).

Aren't both of those examples x86(_64)-specific?  Wouldn't a generic
solution be preferrable?

John
-- 
John W. Linville
linville@tuxdriver.com
