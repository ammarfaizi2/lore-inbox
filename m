Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbWGKBP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWGKBP4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 21:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWGKBP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 21:15:56 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:54088 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965056AbWGKBPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 21:15:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QbQWRRP3OFAKs1RZSKpHXrA4rOKPDKPsBoLnUG5E4ZG+xrCVNT7UHBnQz7y0gzdlWzZaHvu/wrwO6njXpPB6PyT+KpEl7UeZAj4hUUIUcKabT9nUmSRxeEMJr81EzUqEpuX5kTAir4ESwvOhS4ufigYWHwUs/EG2DTtkBEfGeNY=
Message-ID: <e1e1d5f40607101815u51ec0d2ej49a8e91907e051f3@mail.gmail.com>
Date: Mon, 10 Jul 2006 21:15:54 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Automatic Kernel Bug Report
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       "Pavel Machek" <pavel@ucw.cz>, "Adrian Bunk" <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1152574888.19047.44.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com>
	 <20060709191107.GN13938@stusta.de>
	 <e1e1d5f40607091301j723b92bje147932a4395775c@mail.gmail.com>
	 <200607092019.k69KJt66005527@turing-police.cc.vt.edu>
	 <e1e1d5f40607091327y3db1cbdco89ebdb04cda60ce0@mail.gmail.com>
	 <20060710081131.GA2251@elf.ucw.cz>
	 <e1e1d5f40607101040u3baf0da7r43d5538700b02e2@mail.gmail.com>
	 <200607101759.k6AHxbda012403@turing-police.cc.vt.edu>
	 <e1e1d5f40607101505peb27581n729bcb14842d2956@mail.gmail.com>
	 <1152574888.19047.44.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2006-07-10 at 18:05 -0400, Daniel Bonekeeper wrote:
> > That's a good example. Another example: a little while ago
> > (http://lkml.org/lkml/2006/7/1/70) Daniel Drake from Gentoo was
> > reporting a problem where page_mapcount(page) was getting negative. As
> > it turned out, it was related with a nVidia proprietary driver that
> > the machine was running. With the system, we just needed to search for
> > "Eeek! page_mapcount(page) went negative! (-1)" on kernels 2.6.16.19
> > (maybe too generic), and he would see that lots of people reporting
> > that has, between other things, nVidia drivers running. It's already a
> > clue on where to start looking for. The same applies for lots of other
> > stuff.
>
> That sounds backwards to me - any kernel bug reporting system should
> immediately discard bug reports with the nvidia driver loaded, as such a
> kernel is not debuggable.

Our job is to do kernel, and anything related to it should not be discarded.
The system has to have the flexibility to provide the same information
ignoring tainted configurations, if it's that what you need. ("provide
mechanism, not policy")

Daniel

-- 
What this world needs is a good five-dollar plasma weapon.
