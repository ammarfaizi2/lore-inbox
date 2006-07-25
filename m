Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWGYTKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWGYTKA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWGYTKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:10:00 -0400
Received: from terminus.zytor.com ([192.83.249.54]:18073 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964818AbWGYTJ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:09:59 -0400
Message-ID: <44C66C36.2010600@zytor.com>
Date: Tue, 25 Jul 2006 12:08:38 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Neil Horman <nhorman@tuxdriver.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
References: <20060725174100.GA4608@hmsreliant.homelinux.net>	 <1153850139.8932.40.camel@laptopd505.fenrus.org>	 <20060725182208.GD4608@hmsreliant.homelinux.net>	 <1153852375.8932.41.camel@laptopd505.fenrus.org>	 <20060725184328.GF4608@hmsreliant.homelinux.net> <1153853596.8932.44.camel@laptopd505.fenrus.org>
In-Reply-To: <1153853596.8932.44.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> well the idea that has been tossed about a few times is using a vsyscall
> function that either calls into the kernel, or directly uses the hpet
> page (which can be user mapped) to get time information that way... 
> or even would use rdtsc in a way the kernel knows is safe (eg corrected
> for the local cpu's speed and offset etc etc).
> 

x86-64 already does that, IIRC.

	-hpa

