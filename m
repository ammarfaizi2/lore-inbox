Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVCNDmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVCNDmp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 22:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVCNDmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 22:42:45 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:57439 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261499AbVCNDmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 22:42:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZA2MrWNNfiaNWpb4Rql0RlC3KQWThQo6UeBgWAFfXJT5EZA+Urch4TEU/MH8mYr84FPAdk8HbbnKJ1PtY8UnDTRrRcVv2Z6IG1QGNAfwmwP+3JPdsnp9xbK1ToD3W/NTMBCuNfS87QTeClZbL5nWFAojk15iYSo4qCNwXiaEUY4=
Message-ID: <9e4733910503131755509a9364@mail.gmail.com>
Date: Sun, 13 Mar 2005 20:55:10 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.61.0503121009130.2166@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	 <9e473391050312075548fb0f29@mail.gmail.com>
	 <Pine.LNX.4.61.0503121009130.2166@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2005 10:11:18 -0700 (MST), Zwane Mwaikambo
<zwane@arm.linux.org.uk> wrote:
> Alan's proposal sounds very plausible and additionally if we find that
> we have an irq line screaming we could use the same supplied information
> to disable userspace interrupt handled devices first.

I like it too and it would help Xen. Now we just need to modify 800
device drivers to use it.

>         Zwane
> 

-- 
Jon Smirl
jonsmirl@gmail.com
