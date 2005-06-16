Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVFPKOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVFPKOm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 06:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVFPKOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 06:14:42 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:31652 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261537AbVFPKOl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 06:14:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Twz+G9dgPPqtwak94hvWIJpe5iXld/e7vvhvp+IP/XorkW9MahhLHTlbToaQKLQAG5m1Q+GhY/RI1ITtIxeqsik6G/uOh/TLPyvxUJ0Bh4zLnuuEiJoWkbFrq1a6uMTOX/FTtyxG11l9IXx5b8U3BFTg5IwB/sKeBJ/ZJ9Dpy7Q=
Message-ID: <f19298770506160314689ef5a5@mail.gmail.com>
Date: Thu, 16 Jun 2005 14:14:40 +0400
From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Reply-To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
To: Patrick McFarland <pmcfarland@downeast.net>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200506152152.02840.pmcfarland@downeast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f192987705061303383f77c10c@mail.gmail.com>
	 <1118690448.13770.12.camel@localhost.localdomain>
	 <f192987705061513503afb73cb@mail.gmail.com>
	 <200506152152.02840.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/05, Patrick McFarland <pmcfarland@downeast.net> wrote:
> > Now I quite agree that it isn't a Great Idea to do such conversion in
> > the kernel, but the problem still remains and there is no other place
> > we can do it. I belive that it should be done now and removed after
> > the world finishes to move to utf. Maybe it should not be applyed to
> > the main kernel tree, but I'm sure that at least Russian linux
> > distributions will like it.
> 
> I partially agree. I think no userland application should have access to the
> un-'fixed' file names; they should be fed only Unicode to prevent the spread
> and acceptance of out of date encodings.
> 
> Forcing users to do smart things is often the only way to make them do smart
> things, and the lack of acceptance of Unicode on Linux in the wild seems to
> be the only way.

I'm not going to force anybody to do anything. There is a nubmer of
reasons to use  unicode, but if somebody finds them not convincing, he
is free to use any other encoding. If somebody uses koi8-r as his
primary encoding and wants to mount a cp1251 or unicode-encoded file
system, he is free to do it, although he should be ready to loose some
characters.
