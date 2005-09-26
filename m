Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVIZEcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVIZEcL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 00:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVIZEcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 00:32:11 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:37521 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932370AbVIZEcK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 00:32:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YvTUDuvxF+d86ILkwY+Gv8AtFBoPfW3i/G6vlOJZTCQ9FpktW0y5ZKtGdVA1e9f0VIXXmFN7kuHuUyVbQpD9UrKWLAzXR/UItZG0f+D1q4H3tGg+9jYh7NTYH1viDVYRVmkfZkFM3fbruNmu+DUdnWtPSuX+0p1iOp2Zqsihy/w=
Message-ID: <b41d010d05092521324ead6fb0@mail.gmail.com>
Date: Sun, 25 Sep 2005 21:32:09 -0700
From: Carlo Calica <ccalica@gmail.com>
Reply-To: Carlo Calica <ccalica@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc2-mm1
Cc: Paul Blazejowski <paulb@blazebox.homeip.net>, linux-kernel@vger.kernel.org,
       xorg@lists.freedesktop.org
In-Reply-To: <20050925164421.75c734d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050925220037.GA8776@blazebox.homeip.net>
	 <20050925164421.75c734d2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the same problem with 2.6.12.  I'll run some tests with older kernels.


On 9/25/05, Andrew Morton <akpm@osdl.org> wrote:
> Paul Blazejowski <paulb@blazebox.homeip.net> wrote:
> >
> >  Upon quick testing the latest mm kernel it appears there's some kind of
> >  race condition when using dual core cpu esp when using XORG and USB
> >  (although PS2 has same issue) kebyboard rate being too fast.
> >
> >  The same behaviour happens on vanilla 2.6.13 kernel. Reporting this also
> >  to XORG list in hopes to help debug this issue.
>
> Is it possible to narrow this down a bit further?  Was 2.6.12 OK?
>
> If we can identify two reasonably-close-in-time versions either side of the
> regression then the next step would be to run `dmesg -s 1000000' under both
> kernel versions, then run `diff -u dmesg.good dmesg.bad'.
>
>


--
Carlo J. Calica
