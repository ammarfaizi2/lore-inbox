Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030531AbVJGRr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030531AbVJGRr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 13:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030532AbVJGRrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 13:47:25 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:16040 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030531AbVJGRrY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 13:47:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TEbaYxSytZZfNvPlkBJIdDovhnLMbDDYhB4cmiOEguD7q6L5qN2gM2z9GiReOnWJIPVgF7NRYmstXKcCIduzdWz9rIBzngcjGRM6PQ+0EldIx804HkIr4Xb1vkm5I8vj1/B8UBvNwpP7RD82bVR+9xGZ+G34ZzppShZ1qVgWkec=
Message-ID: <5bdc1c8b0510071047o741eb4d7vb73ed0e6d9e44aa3@mail.gmail.com>
Date: Fri, 7 Oct 2005 10:47:23 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.14-rc3-rt10 - xruns & config questions
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1128705805.17981.42.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510061152o686c5774x2d0514a1f1b4e463@mail.gmail.com>
	 <20051006195242.GA15448@elte.hu>
	 <5bdc1c8b0510061307saf22655y26dd1e608b33a40c@mail.gmail.com>
	 <5bdc1c8b0510061338r41e0b51ds2efd435a591d953e@mail.gmail.com>
	 <5bdc1c8b0510061907w372cb406x45140b01e4011c4a@mail.gmail.com>
	 <20051007114848.GE857@elte.hu>
	 <5bdc1c8b0510070944p5a09f7f2m4965f3e0ddda21f7@mail.gmail.com>
	 <1128705805.17981.42.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-10-07 at 09:44 -0700, Mark Knecht wrote:
> > Hi Ingo,
> >    OK, I've been running -rt10 for the last couple of hours on a new
> > kernel without SMP. No xruns so far at 64/2. I'm doing all the normal
> > stuff. emerge sync, building some code outside of portage, playing
> > music. Very good so far, but it will likely take 4-6 hours for me to
> > be more sure saying it was just SMP latencies.
>
> IIRC you posted some traces that implied the migration thread was
> involved.
>
> Lee

No Lee, I don't think I've posted any traces myself. Possibly someone else?

I need to learn how to debug where time is spent by the kernel when an
xrun occurs. I haven't yet tried some brief instructions you gave me a
couple of weeks back.

Anyway, I'm now about 3 hours down the road with no xruns now that
I've turned of SMP support. Is the migration thread part of SMP
support?

Thanks,
Mark
