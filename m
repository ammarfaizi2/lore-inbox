Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbWAJVDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbWAJVDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbWAJVDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:03:24 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:49428 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932648AbWAJVDX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:03:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IsZvWpJuDcCvFkKBBamm8a7DGGwgIHuyrM+jock+4IR6Ykq/lqecm9UTksa58soyfOQV0FMa33ZeO4HwQvZqF6LdDVHbe8Eoe5aIK31QWejdOIq/SJSQEcWoi0ub++zeoze4GDg8PzfmWmEH/UQ/IvdA4lnxJE0gQ7uJ7ox713M=
Message-ID: <9a8748490601101303r2e44e39at5f0f10bd82180add@mail.gmail.com>
Date: Tue, 10 Jan 2006 22:03:20 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
Subject: Re: [PATCH] Megaraid cleanup
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Kolli, Neela" <Neela.Kolli@engenio.com>, linux-scsi@vger.kernel.org
In-Reply-To: <9738BCBE884FDB42801FAD8A7769C265142001@NAMAIL1.ad.lsil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9738BCBE884FDB42801FAD8A7769C265142001@NAMAIL1.ad.lsil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/06, Ju, Seokmann <Seokmann.Ju@lsil.com> wrote:
> Hi,
> > Ok, I went into drivers/scsi/megaraid.c just to fix a few
> > compiler warnings,
> > but ended up doing a big spring-cleaning.
>
> Thank you for the patch first of all.

You're welcome.

> I would like to step through the changes in the patch and
> Will get back to you.
> I would think you've already verified the patch by testing
> The updated driver. Please confirm this.
>
As far as I could without having access to actual hardware, yes.
That means I've read through my changes and tried to verify them
visually/logically.
I've also compile tested it - it builds fine.
And I've also attempted to load it, and it fails (due to no hardware)
as it's supposed to.
Beyond that I'm unable to test it.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
