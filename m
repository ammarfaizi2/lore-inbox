Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVHLTI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVHLTI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVHLTI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:08:29 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:16061 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751242AbVHLTI2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:08:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pCRC0vQ91Ul/9/3cxAIYASKA4JRGgOaFn6ttnxKBVIovbAlVF09iAx1/J3om9gcKe7rc0+rY88b7EyxVKxO71T+YN69iOOQS9GmI/9zJ8Kyw9Ej+qgkz7A/u8d2A1Lt3dqomDed+0/9MR4QD1DhO/np5LCJI8V3U7f2Mx8nOnko=
Message-ID: <7f45d93905081212087ea5910a@mail.gmail.com>
Date: Fri, 12 Aug 2005 12:08:27 -0700
From: Shaun Jackman <sjackman@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Trouble shooting a ten minute boot delay (SiI3112)
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0508122039390.16845@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f45d939050809163136a234a@mail.gmail.com>
	 <42FC0DD4.9060905@gmail.com>
	 <7f45d93905081201001a51d51b@mail.gmail.com>
	 <42FC57EC.2060204@pobox.com>
	 <7f45d93905081210441e209e31@mail.gmail.com>
	 <Pine.LNX.4.61.0508122039390.16845@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/8/12, Jan Engelhardt <jengelh@linux01.gwdg.de>:
> >Thanks for the hint. I tried edd=off but sadly the boot delay
> >persists. It looks as though edd was already disabled, as my .config
> >contains CONFIG_EDD=m and the edd module is not loaded. If it helps
> >troubleshooting I can post my .config here.
> 
> Maybe you can get something using EARLY_PRINTK and/or Sysrq+T?

I tried earlyprintk=vga, but it didn't provide any extra information.
Although, CONFIG_EARLY_PRINTK is disabled in my .config. Does it need
to be set to CONFIG_EARLY_PRINTK=y for earlyprintk=vga to work?

I haven't tried Sysrq+T yet. I'll report back.

Cheers,
Shaun
