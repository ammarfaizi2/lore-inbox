Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVETLuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVETLuA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 07:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVETLuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 07:50:00 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:23521 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261433AbVETLt7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 07:49:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dExGyVYLsGG20EeeC9oZFfofPoHFkVN27ISk1bsuzQI1ZM2VPbAhaDTOYw293VjIIIS4R8jAvyd1tMEktS7v12Yzd2uFxaglTyKI7QBmTyMxRbrVTeued21JtE+QbfYyHgesY3fi9IvgwRzE89tLx7sLk8qS4KXTuHJD2UUI9kY=
Message-ID: <21d7e99705052004493a4cdcd2@mail.gmail.com>
Date: Fri, 20 May 2005 21:49:58 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Illegal use of reserved word in system.h
Cc: "Gilbert, John" <JGG@dolby.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1116524233.21358.292.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2692A548B75777458914AC89297DD7DA08B08670@bronze.dolby.net>
	 <1116524233.21358.292.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> DRI one does seem to be a real bug.

Well not a bug :-) but lets call it a C++ incompatibility .. I'll see
how much work it is to change this everywhere it is used..  I don't
really want to break loads of userspace apps.. not that many drm apps
exist.. and probably very few of them use the virtual pointer...

Dave.
