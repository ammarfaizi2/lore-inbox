Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVBNI06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVBNI06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 03:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVBNI05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 03:26:57 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:26380 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261369AbVBNI0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 03:26:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZEenZX1AfDxI/uT7x/2PPoviLObfjVShRbzQ0Z98JtnhSgw3SGhN2gJ6Q0B2dbSSbHv8bbTkiwNXGEFjW8a4d8DRGiyyuj5PvpOPLMrOZSnn9euHip934wYMUDt53zremcO3d48mlJJxUtZWDrXcU1JUx9vd5kKvgwULHFnY5fA=
Message-ID: <21d7e99705021400266bcbc0f2@mail.gmail.com>
Date: Mon, 14 Feb 2005 19:26:52 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: SiS drm broken during 2.6.9-rc1-bk1
Cc: mingo@elite.hu, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0502131124090.16528@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0502131124090.16528@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> layout is the most likely patch to have broken things... I haven't
> confirmed it is this particular patch yet, tomorrow I'll get some time to
> do it ..
> 

okay running client applications using 

setarch -L i386 glxgears

makes them work.. I'll start looking for a bug in the the SIS client
side library..

Dave.
