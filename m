Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317118AbSEXKEh>; Fri, 24 May 2002 06:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317119AbSEXKEh>; Fri, 24 May 2002 06:04:37 -0400
Received: from [62.70.58.70] ([62.70.58.70]:18322 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317118AbSEXKEf> convert rfc822-to-8bit;
	Fri, 24 May 2002 06:04:35 -0400
Message-Id: <200205241004.g4OA4Ul28364@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
Date: Fri, 24 May 2002 12:04:30 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200205231311.g4NDBO613726@mail.pronto.tv> <200205231629.g4NGTWE22956@mail.pronto.tv> <399720000.1022172368@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have 1 gig - highmem (not enabled) - 900 megs.
> > for what I can see, kernel can't reclaim buffers fast enough.
> > ut looks better on -aa.
>
> Sounds like exactly the same problem we were having. There are two
> approaches to solving this - Andrea has a patch that tries to free them
> under memory pressure, akpm has a patch that hacks them down as soon
> as you've fininshed with them (posted to lse-tech mailing list). Both
> approaches seemed to work for me, but the performance of the fixes still
> has to be established.

Where can I find the akpm patch?

Any plans to merge this into the main kernel, giving a choice (in config or 
/proc) to enable this?

> I've seen over 1Gb of buffer_heads ;-)
>
> M.

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.
