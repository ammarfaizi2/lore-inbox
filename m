Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWBZStk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWBZStk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 13:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWBZStk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 13:49:40 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:44689 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750766AbWBZStj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 13:49:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lNegi0fXA3eGyaTI+BoNqGGLosP+OmCyMduIkxZag4x7A63YXIMUUKDFGTf7tEAWBsIvKOmSS8Y42G0lxMIJUhPkioBb6EzNY8HjhLcxZmwgMRToDH8y/QrqtqeM5Z61xCaJHlIY61+s810nfShLAfYdAuas4HcuURvTIr9hn/Y=
Message-ID: <9a8748490602261049q32146506vdbd54fa833acbbd4@mail.gmail.com>
Date: Sun, 26 Feb 2006 19:49:38 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Subject: Re: hda: irq timeout: status=0xd0 DMA question
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4401F6BA.5010607@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5KtPb-2oP-9@gated-at.bofh.it> <5Kxzs-7M7-19@gated-at.bofh.it>
	 <5KxJa-7XQ-31@gated-at.bofh.it> <5KxT2-8a6-15@gated-at.bofh.it>
	 <5KyFa-RL-1@gated-at.bofh.it> <4401F6BA.5010607@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Robert Hancock <hancockr@shaw.ca> wrote:
> Henrik Persson wrote:
> > Does happen once or twice a year.. Probably something funky with the
> > cabling or some power-related issues.
> >
> > Anyway, I would be happy if the IDE driver would "just not do that". :)
>
> I can see the reasoning where the device just doesn't function properly
> with DMA at all (like on some Compact Flash-to-IDE adapters where the
> card claims to support DMA but the DMA lines aren't wired through in the
> adapter properly). In that case not disabling DMA would render it
> useless. The IDE layer could keep track of whether DMA was previously
> working on that device however, and not disable DMA on reset if it had
> previously been working.
>
That might be even better than an option to tell the driver "I don't
want you to disable DMA on reset".

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
