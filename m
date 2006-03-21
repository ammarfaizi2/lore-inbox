Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWCUXWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWCUXWS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWCUXWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:22:18 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:51516 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750866AbWCUXWR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:22:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Go78iPXE6WTvabi13Oiwf4cC+OQmgnRQikIQVvNqfdyuKbY9/yvkYpFeMiZHZJkAJTnr3alyDZX93JNt9SkieOvYaWvO7EeYKfrSqHTX+IWjPRzLi8SJQmPBGvqtXmGC9ZKhxhMmLfBENL/qLDRd+L5KN0n+sZLkJkGpyBahobI=
Message-ID: <6bffcb0e0603211522i38437774x@mail.gmail.com>
Date: Wed, 22 Mar 2006 00:22:16 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.16-rt1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060321202410.GA22324@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060320085137.GA29554@elte.hu>
	 <200603211430.29466.Serge.Noiraud@bull.net>
	 <20060321170149.GA27290@elte.hu>
	 <6bffcb0e0603211036i7cce3776p@mail.gmail.com>
	 <20060321202410.GA22324@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> > Hi Ingo,
> >
> > On 21/03/06, Ingo Molnar <mingo@elte.hu> wrote:
> > >
> > > could you check -rt2?
> > >
> >
> > Here is first oops http://www.stardust.webpages.pl/files/rt/2.6.16-rt2/b1.jpg
> > Here is second oops http://www.stardust.webpages.pl/files/rt/2.6.16-rt2/b2.jpg
> >
> > Here is config http://www.stardust.webpages.pl/files/rt/2.6.16-rt2/rt-config
> >
> > I can't boot that kernel, 2.6.16-rt1 was fine.
>
> ok, i broke irqs-off latency tracing in -rt2. Could you try -rt3 - it
> should be fixed there.
>
>         Ingo
>

Thanks!
Problem fixed.

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
