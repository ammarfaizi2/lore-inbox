Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVHLRpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVHLRpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVHLRo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:44:59 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:2315 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750728AbVHLRo6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:44:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LPvJOe2nD3ahg4I0SVmSDVg5jaeVCHBLE1u7n0PwTobdC6rE0rvb18pnxT08FYi5HzRU7BqF6xU6Is9580KZlg6bwuDxVpFJA8h9Kns57voCG320LAesopks6GCPdPY7kkllvWAurarhoNUJ3wgeY0sLiT4yFpDytc56w504ATI=
Message-ID: <7f45d93905081210441e209e31@mail.gmail.com>
Date: Fri, 12 Aug 2005 10:44:53 -0700
From: Shaun Jackman <sjackman@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Trouble shooting a ten minute boot delay (SiI3112)
Cc: Tejun Heo <htejun@gmail.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <42FC57EC.2060204@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f45d939050809163136a234a@mail.gmail.com>
	 <42FC0DD4.9060905@gmail.com>
	 <7f45d93905081201001a51d51b@mail.gmail.com>
	 <42FC57EC.2060204@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/8/12, Jeff Garzik <jgarzik@pobox.com>:
> > At this point there is a nine minute, fifteen second delay. As soon as
> > the kernel starts printing messages it goes by quite fast, so I can't
> > be certain what it's printing, but the first message according to
> > dmesg is...
> > Linux version 2.6.11-1-k7 (dannf@firetheft) (gcc version 3.3.6 (Debian 1:3.3.6-6
> > )) #1 Mon Jun 20 21:26:23 MDT 2005
> > BIOS-provided physical RAM map:
> 
> It's doing something BIOS-related at that point.
> 
> Try booting with 'edd=off' or disabling CONFIG_EDD.

Thanks for the hint. I tried edd=off but sadly the boot delay
persists. It looks as though edd was already disabled, as my .config
contains CONFIG_EDD=m and the edd module is not loaded. If it helps
troubleshooting I can post my .config here.

Cheers,
Shaun
