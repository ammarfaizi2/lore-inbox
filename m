Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVEVNFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVEVNFU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 09:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVEVNFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 09:05:20 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:13448 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261801AbVEVNFI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 09:05:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RNEc2hUSy4RGgdUjxFSVrPe7/OY7aRU8sMoEXAI9AGzydV8f+LwidphaL3LkiXcABTVMvwR5ttrhtw4PR8725ajCVZjKtClWaMf7I1tIWIbbqr0AVv0eUl4Ip4MWqC1Uyb/DUvmfO9lAVkjUiKbxrKSqcR9HaAOk6OSFHUz4lB0=
Message-ID: <25381867050522060561a288c@mail.gmail.com>
Date: Sun, 22 May 2005 09:05:04 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15] drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <20050522143244.3648427a.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050519213551.GA806@kroah.com>
	 <200505212058.14851.dtor_core@ameritech.net>
	 <20050522085026.40e73d49.khali@linux-fr.org>
	 <200505220204.52907.dtor_core@ameritech.net>
	 <25381867050522051524ea93ec@mail.gmail.com>
	 <20050522143244.3648427a.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyway there's a long long way to go before there is a true separation
> between i2c and hwmon. Mark introduced a hwmon class, which is needed
> but not sufficient. The biggest part of the work will be to move all
> drivers abusing the i2c subsystem to the subsystem where they really
> belong (isa/platform or superio), and get rid of i2c-isa. 

And i2c-ipmi remember? :) Does that mean Mark's class is finalized and
I can work with it? Or is there some more work to be done on that
front too? If so I can probably help out.

Yani
