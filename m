Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbWBGLOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWBGLOM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 06:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWBGLOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 06:14:12 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:25325 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965016AbWBGLOL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 06:14:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bCwfngNzyLG7LHVCBXT/nIgrgjo88UiXVyqmlMCRWDlf//ty4Viuhl3tHPZE+yXgFvcOJw4kq04IyZsbftlnh42DrJBbjr72SC4PnRt3ajWbE+kIJOgsNnwkFyUb94fje5ost9Y6e9E4L75GOMhBY9UnlvhAXI1t6h2RTK+joH8=
Message-ID: <58cb370e0602070314l35b7c88blbe53844939c86f66@mail.gmail.com>
Date: Tue, 7 Feb 2006 12:14:09 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: DMA in PCI chipset -- module vs. compiled-in
Cc: Lee Revell <rlrevell@joe-job.com>, William Park <opengeometry@yahoo.ca>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1139310456.18391.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060206034312.GA2962@node1.opengeometry.net>
	 <1139200372.2791.208.camel@mindpipe>
	 <1139255365.10437.49.camel@localhost.localdomain>
	 <1139257535.2791.298.camel@mindpipe>
	 <58cb370e0602070014p3d21c8a4u1ca3c5951892cf52@mail.gmail.com>
	 <1139310456.18391.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2006-02-07 at 09:14 +0100, Bartlomiej Zolnierkiewicz wrote:
> > * chipset specific driver
> >
> > The most common mistake is to built-in ide-generic driver
> > and compile chipset specific driver as module...
>
> Oh that no longer works. That worked in 2.4, as it would take over the
> chipset. Didn't work if it was in use at the time but did work correctly
> if idle.

I'm talking about _driver_ here and it works just fine.

If you are talking about "taking over" feature, you are right.
It was racy and indeed "worked" depending on timing.

Bartlomiej
