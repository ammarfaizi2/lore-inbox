Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWEARAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWEARAw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWEARAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:00:52 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:56560 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932153AbWEARAv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:00:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bUDHKfzrmTdEYnJb+3/1eHKwFWA0YQm7Uc3M0FhyKWt7awzpqsZrSTqRi/bSdPXFwNYKeEGUR8zBREn+ORofidVe4uOGsun0wHpWAvHMpLVhclvXkwVBfWFVGpPngqMQjbddBBGzGugga2e0FkeIlghz76FQGA2/+T2KLcoDwG0=
Message-ID: <728201270605011000vb9ac582vf6e1b7a29a3de618@mail.gmail.com>
Date: Mon, 1 May 2006 17:00:51 +0000
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "Denis Vlasenko" <vda@ilport.com.ua>
Subject: Re: select takes too much time
Cc: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>,
       "linux mailing-list" <linux-kernel@vger.kernel.org>
In-Reply-To: <200604201201.50981.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com>
	 <20060413153028.GA26480@rhlx01.fht-esslingen.de>
	 <728201270604130911y4adf9967kd38712e731161074@mail.gmail.com>
	 <200604201201.50981.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/06, Denis Vlasenko <vda@ilport.com.ua> wrote:
> On Thursday 13 April 2006 19:11, Ram Gupta wrote:
> > On 4/13/06, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> > > Hi,
> > >
> > > Now if you have issues with select() taking too long, then I'd say tough
> > > luck, that's life, other processes seem more important than y


Select takes too much time only when I am having a lot of disk i/o. It
also adversely affect scheduling . It is taking too much for the
process to wake up after the timer expires. I dont see the reason why
that should happen. May be one of you may explain that.

Thanks
Ram Gupta
