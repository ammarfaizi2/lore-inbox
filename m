Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWDKC7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWDKC7B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 22:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWDKC7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 22:59:01 -0400
Received: from nproxy.gmail.com ([64.233.182.184]:29752 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932266AbWDKC7A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 22:59:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=INBs51RAQn1gsJAx8SZlAlLeOX0AQdOvWxkU3R1iW5xjabgzyZ6EmC1fDPma1FTX5V0axoYMB9pRhI41iNbxFTn2hZwCe4T4ceCgymlFssAI+hHvn6SzL2g1PGOo3i8iJu4V4DS4RT8pmOKvAJtFVzoNMEIt275GVE02fhpiWa0=
Message-ID: <6d6a94c50604101958t3ae9b9d2s5387b39dc09ac2c1@mail.gmail.com>
Date: Tue, 11 Apr 2006 10:58:48 +0800
From: Aubrey <aubreylee@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: The assemble file under the driver folder can not be recognized when the driver is built as module
Cc: "Adrian Bunk" <bunk@stusta.de>, "Erik Mouw" <erik@harddisk-recovery.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0604101402400.26129@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6d6a94c50604100316j43bcc32p6fa781c0ce47182d@mail.gmail.com>
	 <20060410112817.GE12896@harddisk-recovery.com>
	 <6d6a94c50604100627q297b7335yb58288356aaa8edd@mail.gmail.com>
	 <20060410174252.GD2408@stusta.de>
	 <Pine.LNX.4.61.0604101402400.26129@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > IOW, you want:
> >
> >  obj-$(CONFIG_FB_BFIN_7171)   += bfin_ad7171fb.o
> >  bfin_ad7171fb-objs           := bfin_ad7171fb_main.o rgb2ycbcr.o
> >
> > Note that this requires renaming bfin_ad7171fb.c to bfin_ad7171fb_main.c.

That's the trick. Thanks.

Regards,
-Aubrey
