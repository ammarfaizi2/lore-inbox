Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbUL2MoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbUL2MoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 07:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbUL2MoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 07:44:12 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:65356 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261214AbUL2MoI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 07:44:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=RoM5/u9AAwWxEtzTiXYmDt6gUnN6mOmo6NRZA+sRRlzizgcsoE0fd4sxpIQX01k3Q0Jdwiky5P1VkNm91cKuTNoFA+DBipcjsUySkpBHNk1/wc3H+7luXvKNQScmasIGLWEoj4WQEqGCZMkyeMr4mzXJquwbPDwaZErPy8T44P8=
Message-ID: <4d8e3fd304122904442a602a8@mail.gmail.com>
Date: Wed, 29 Dec 2004 13:44:08 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Ho ho ho - Linux v2.6.10
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1103977161.22646.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org>
	 <1103977161.22646.6.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Dec 2004 12:19:24 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2004-12-24 at 22:39, Linus Torvalds wrote:
> > Ok, with a lot of people taking an xmas break, here's something to play
> > with over the holidays (not to mention an excuse for me to get into the
> > Glögg for real ;)
> 
> Merry Yule to you too.
> 
> Not wishing to be too ungrateful to Santa but
> 
> - The broken AX.25 patches are not reverted so that doesn't work on some
> networks
> 
> - It seems the security hole inducing exec_id change was not reverted
> and I've not yet found any other changes that fix the same problem
> (setuid_app >/proc/self/mem) in 2.6.10. It was actually quite nasty as a
> hole because you can seek the fd to the right target address before
> execing. With the other /proc changes did I miss something on this one
> 
> I'll check it all over in more detail when I generate 2.6.10-ac
> (probably tomorrow), which will be nice as the patch will be a _lot_
> shorter and USB storage a lot happier than 2.6.9 based systems.
> 

Having at least a -rc or maintaining a 2.6.XY.Z branch would avoid
these problems in my very humble opinion.

Best,

-- 
Paolo Ciarrocchi
