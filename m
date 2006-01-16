Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWAPIfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWAPIfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 03:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWAPIfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 03:35:41 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:21441 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932210AbWAPIfk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 03:35:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gK9nwxlPoKQiuQS3oHmIPW8GcaJj4GpLn77hZN5UYLXPO1bobVHm2vqDzjqTSUX987CSw2gt1OKHq+u20iUSKtC5tD+hadgjIuRWJjdKD/7+azhdITKFkGSNhijky+0xaXkOgfKl2uHSBJ8Hms7dzMWU+eM90yLD0agioBpmJXw=
Message-ID: <84144f020601160035y1ac037b2kfdc2ff4be5bacd79@mail.gmail.com>
Date: Mon, 16 Jan 2006 10:35:38 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>
Subject: Re: io performance...
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43CB4CC3.4030904@fastmail.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43CB4CC3.4030904@fastmail.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/16/06, Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk> wrote:
> I've noticed that I consistently get better (read) numbers from kernel 2.6.8
> than from later kernels.

[snip]

> The later kernels I've been using are :
>
> 2.6.12-1-686-smp
> 2.6.14-2-686-smp
> 2.6.15-1-686-smp
>
> The kernel which gives us the best results is :
>
> 2.6.8-2-386
>
> Any ideas to why this might be? Any other advice/help?

It would be helpful if you could isolate the exact changeset that
introduces the regression. You can use git bisect for that. Please
refer to the following URL for details:
http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bisect.txt

Also note that changeset for pre 2.6.11-rc2 kernels are in
old-2.6-bkcvs git tree. If you are new to git, you can find a good
introduction here: http://linux.yyz.us/git-howto.html. Thanks.

                               Pekka
