Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWEQRV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWEQRV4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 13:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWEQRVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 13:21:55 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:4432 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750743AbWEQRVz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 13:21:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qbnXdSx7AMqMi0OEAwIc1oFpKNkimAh1QPoPEyizQj2bkQPDNoDDd0xQ5BmZVA4pW4gBr5XaMtaLC9OgYE5lb0WDWVZqupLWDo7RQ/RXVacWakTDbXciqJAsg2j4HeraDDIWoRuXUxyoW2sL1jKfQDNVhNyww9/80DxyIMkpejY=
Message-ID: <2c0942db0605171021n1ebcb8adhcd552d33283ab0@mail.gmail.com>
Date: Wed, 17 May 2006 10:21:54 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Con Kolivas" <kernel@kolivas.org>
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
Cc: "Mike Galbraith" <efault@gmx.de>, linux-kernel@vger.kernel.org,
       tim.c.chen@linux.intel.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, mingo@elte.hu,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <200605180110.22270.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4t16i2$12rqnu@orsmga001.jf.intel.com>
	 <200605172246.39444.kernel@kolivas.org>
	 <1147873294.7596.13.camel@homer>
	 <200605180110.22270.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/06, Con Kolivas <kernel@kolivas.org> wrote:
> > Ok, I'll accept that.  Spits and stutters _are_ interactivity issues
> > though yes?.  Knowing full well that plunking long sleepers into the
> > queue you are plunking them into causes spits and stutters, why do you
> > insist on doing so?
>
> Because I know of no real world workload that thuds us into spits and
> stutters.

`apt-get dist-upgrade` seems to do wonders for making a system
thoroughly unusable. Possibly because it forks a copy of perl and a
few other tasks, all competing for CPU and disk I/O bandwidth -- at
least, competing when they're not sleeping most of the time. Y'all
might add a chroot'd install of Debian as a test case.

Ray
