Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWBTAmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWBTAmR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWBTAmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:42:16 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:33696 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751154AbWBTAmP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:42:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qpBKFMYO4gO56npJf7eChnoD5p1ZG6uVxrIFji2y+g7GWBXgEPFdm3mtaq7Ebg5w4W1kg+pM3DMJRJjeV4ATHBFFBZpzbDriEjiiPQsp7iOHUY64HkBAaamzLLfa5HyXdkHOS83JPOydrhed1otjWKcgjifTWfvyHlpN0EtnzIE=
Message-ID: <3420082f0602191642s4e18f32auddcc3b45a449e774@mail.gmail.com>
Date: Mon, 20 Feb 2006 05:42:13 +0500
From: "Irfan Habib" <irfan.habib@gmail.com>
To: "Chris Wedgwood" <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: How to find the CPU usage of a process
In-Reply-To: <20060219190640.GA4929@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060218174229.76852.qmail@web32603.mail.mud.yahoo.com>
	 <20060219190640.GA4929@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thank you very much for every one who replied.
It really helped me big times :)

On 2/20/06, Chris Wedgwood <cw@f00f.org> wrote:
> On Sat, Feb 18, 2006 at 09:42:29AM -0800, Irfan Habib wrote:
>
> > I wanted to ask how can I find the cpu usage of a process, as
> > opposed to runtime, with cpu usage I mean actually how many time
> > slices were awarded to a specific process, like the runtime of job
> > may be 4 s, but this also includes time it was suspended by some
> > interrupt, or had to wait for the scheduler etc..
>
> getrusage(2) or if it's not a child then grovel through /proc (i think
> there is an argument for a better interface)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
