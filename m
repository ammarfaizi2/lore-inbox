Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVFMRVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVFMRVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 13:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVFMRVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 13:21:13 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:24620 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261563AbVFMRU5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 13:20:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ow7Z19jpYfVIC7VRVv/vwi8ojrgoNWrQJ6eA9qHFz5SRbgX6n0fchmCCFw2hzf2P5rAUGUbjgB6dRfA3lCxqC5RZyL4L1ewxiOjSeZrV0eQHxnvKzWNO3kejhLTrvyRSuB5eMlDqK8o3xoDIpwUmglv0Foz4935jtQMv8F253g4=
Message-ID: <f192987705061310202e2d9309@mail.gmail.com>
Date: Mon, 13 Jun 2005 21:20:53 +0400
From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Reply-To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1118669746.13260.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f192987705061303383f77c10c@mail.gmail.com>
	 <1118669746.13260.20.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Llu, 2005-06-13 at 11:38, Alexey Zaytsev wrote:
> > Instead of adding NLS support to filesystems who don't have it yet, I
> > think there should be a global NLS layer, to convert file names from
> > any to any encoding, independent of file system and transparently to
> > the user.
> 
> Thats essentially what we have. The core OS is UTF-8, the fat and one or
> two other legacy file systems support mapping old and/or inferior
> encodings into utf-8 (and some other stuff).

Yes, that's how it works, but if I want ext or reiser or whatever to
have NLS, I'll have to make them support it (btw, if I do so, wont it
be rejected?). I want to move the NLS one level upper so the
filesystem imlementations won't have to worry about it any more. I
don't have much kernel experience, and none in the fs area, so I can't
explain it any better, but hope you get the idea.

> Alan
 Thank you answering.
