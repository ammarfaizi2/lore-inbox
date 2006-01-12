Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWALHqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWALHqd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 02:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWALHqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 02:46:33 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:27558 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932088AbWALHqc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 02:46:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HwbdP6LbQksSb7Z3B5fq9chavu/tf3l0XMkG3xn3dkgFFvkilkMwY5nCJIbvXEPjYxupWQ7PRbQoaBTrVYQCkGSSY8NV4vgjFAFYmBbgJhI7pYX6X9mq3uabteatz7Ys3jSlyY6mN187bRdiXYhGh7unvbH4gjER+Hvm1cCouAc=
Message-ID: <21d7e9970601112345p9306310ud935735f3b44e565@mail.gmail.com>
Date: Thu, 12 Jan 2006 18:45:58 +1100
From: Dave Airlie <airlied@gmail.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Subject: Re: [2.6.15-git6,-git7] hard lockup on FC4 exiting X (Intel I915)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5a4c581d0601111647i62f8c625q51a420ba9a9175e5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0601111647i62f8c625q51a420ba9a9175e5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  startx, fire up a gnome-terminal, exit it, Desktop->Logout...
>  at this point the mouse arrow stills and the box locks up,
>  keyboard dead, no response to pings.
>

Normally I'd accept blame for this, but I've not merged up yet, so at
a guess the mutex patches probably did something... if not the some
PCI ones perhaps..

I don't suppose you can get a serial console hooked up (probably no
real serial on that machine) or a netconsole..

Dave.
