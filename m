Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbUKLQQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbUKLQQw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 11:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbUKLQQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 11:16:51 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:43044 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262566AbUKLQQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 11:16:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WDobHZkVniSkpOhmqVizyvXnQSMjD76X2XFG5bplVXAHMNvDSfUCvAeFxgBF5kR79MnqDLUbr63FFxb/SgOYBzj3/lI5+blXrSYXjCU//vbTD83P9aOhPMd4xOKU2LA1W6wv3f4IekpvLSVobRIQz7AeCQPIMYscpVgP6LdFJIE=
Message-ID: <1a56ea390411120816c808c3c@mail.gmail.com>
Date: Fri, 12 Nov 2004 16:16:40 +0000
From: DaMouse <damouse@gmail.com>
Reply-To: DaMouse <damouse@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.10-rc1-mm5: REISER4_LARGE_KEY is still selectable
Cc: Vladimir Saveliev <vs@namesys.com>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20041112132343.GF2310@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041111012333.1b529478.akpm@osdl.org>
	 <20041111165045.GA2265@stusta.de>
	 <1100243278.1490.42.camel@tribesman.namesys.com>
	 <20041112132343.GF2310@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004 14:23:43 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> On Fri, Nov 12, 2004 at 10:07:59AM +0300, Vladimir Saveliev wrote:
> 
> > Hello
> 
> Hi Vladimir,
> 
> > On Thu, 2004-11-11 at 19:50, Adrian Bunk wrote:
> > > REISER4_LARGE_KEY is still selectable in reiser4-include-reiser4.patch
> > > (and we agreed that it shouldn't be).
> >
> > Sorry, concerning this problem - what did we agree about?
> 
> depending on the setting of REISER4_LARGE_KEY, there are two binary
> incompatible variants of reiser4 (which can't be both supported by one
> kernel).
> 
> Therefore, REISER4_LARGE_KEY shouldn't be asked but always enabled.
> 
> 
Is there a good reason to actually keep it in the kernel altogether?
methinks ripping it out entirely would be nicer than setting a config
default.

-DaMouse

> 
> cu
> Adrian
> 
-- 
I know I broke SOMETHING but its their fault for not fixing it before me
