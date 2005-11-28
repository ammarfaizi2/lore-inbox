Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVK1Udy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVK1Udy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 15:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVK1Udx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 15:33:53 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:6167 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932236AbVK1Udw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 15:33:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=En3BxFw4jIaP89nXAv/RxEcx/xMpQR5DMy5FHTjIy4aRa+sXhlC1SG8cuv3tz6wInQ8SRd3kkIXzu5+XdOnqtQP6P9gpJ7BzLEX7kOzM9VRmm5W3P8IeY8rDTJUrpwM1zFISvwRpuYAZ6M53OTJ2BdI6EoQLr/mb1V/MHBK/REU=
Message-ID: <35fb2e590511281233r49668895hc3295fce4cfe891b@mail.gmail.com>
Date: Mon, 28 Nov 2005 20:33:52 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct ..."
Cc: Andrew Morton <akpm@osdl.org>, cp@absolutedigital.net,
       linux-kernel@vger.kernel.org, jcm@jonmasters.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@lst.de
In-Reply-To: <438B4E85.2060801@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>
	 <20051116005958.25adcd4a.akpm@osdl.org>
	 <20051119034456.GA10526@apogee.jonmasters.org>
	 <20051121233131.793f0d04.akpm@osdl.org>
	 <35fb2e590511220356x75a951f1t8a36d0556a940751@mail.gmail.com>
	 <20051122141628.41f3134f.akpm@osdl.org> <438B4E85.2060801@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/05, Bill Davidsen <davidsen@tmr.com> wrote:

> I think that's best, because there are few people (relatively) using
> floppy, and those who are probably are used to old behaviour.

The point of the thread is more that this exposes behaviour which
might be present in other drivers too - assuming the block device
state matches the underlying media.

I was out of commission over the weekend after too much pumpkin pie,
but I'll sort this out this week and send out some patches.

Jon.
