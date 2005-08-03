Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVHCAOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVHCAOK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 20:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVHCAOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 20:14:10 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:40624 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261939AbVHCAOI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 20:14:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gVDPPTzY35zxNOo+O2ff+TWCYT5UL4O6LfWt9Qma1LbflhPzaVKAQjs5nG+QIL9cpVkaNIoXvzV4GJ6/T7JszOzToyXH48PHqiUqcggVebNSYQkPqpGfQe3Yg05fzxJfSzpjV5Jl0phe5vFQIFMsZHSb36FBvuSkhSQu7ffJJuA=
Message-ID: <5a67a16f050802171478233f2f@mail.gmail.com>
Date: Tue, 2 Aug 2005 20:14:06 -0400
From: Athul Acharya <aacharya@gmail.com>
Reply-To: Athul Acharya <aacharya@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Determining if the current processor is Hyperthreaded
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42EFB3BB.1060900@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a67a16f05072909245ae1c44c@mail.gmail.com>
	 <42EFB3BB.1060900@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/05, Bill Davidsen <davidsen@tmr.com> wrote:
> Athul Acharya wrote:
> > Hey folks,
> >
> > Is there a quick way to determine if the current processor is
> > Hyperthreaded, and if so, which logical processor represents the other
> > thread on the chip? Please cc replies to me as I am not subscribed to
> > the list :-)
> 
> Look at /proc/cpuinfo and see if "siblings" is listed and more than one.
> There is no "other thread" there, it's like "which one is the other hand?"


Sorry, I should've been more specific -- I mean within the kernel. 
That is, I want to know whether the current cpu I (kernel code) am
executing on is hyperthreaded, and if so, which logical cpu represents
the other thread on chip.

Athul
