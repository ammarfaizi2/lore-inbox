Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVCPPLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVCPPLU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 10:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbVCPPLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 10:11:20 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:36764 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262613AbVCPPLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 10:11:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bDWxIkD4Sw3Oy0+wrAUGzzCu6sEHxrQiIoB2dAADySGWAwUUzmW4qjGFSFtF3pxBYxsZ8sKiK6AIacVGOrl7fEja2n2hlGfEvAaEKyqreo7GOgWc0b0iP6JKajhQD9QUaclcYkfn7iod5cJxbtbfDEOemu3O3tVfA3scQdrgIjU=
Message-ID: <5a2cf1f60503160711137dbff3@mail.gmail.com>
Date: Wed, 16 Mar 2005 16:11:11 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
Reply-To: jerome lacoste <jerome.lacoste@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: enabling IOAPIC on C3 processor?
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1110918157.17931.18.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <5a2cf1f6050315040956a512a6@mail.gmail.com>
	 <1110918157.17931.18.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 15:22:36 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> On Tue, 2005-03-15 at 13:09 +0100, jerome lacoste wrote:
> > I have a VIA Epia M10000 board that crashes very badly (and pretty
> > often, especially when using DMA). I want to fix that.
> >
> 
> Are the crashes associated with any particular workload or device?  My
> M6000 works perfectly.
> 
> The one big problem I had with is is the VIA Unichrome XAA driver had a
> FIFO related bug that caused it to stall the PCI bus, delaying
> interrupts for tens of ms unless "Option NoAccel" was used.
> 
> This bug was fixed over 6 months ago though.

It crashes my box within minutes if not seconds when using mythtv
(tuner using ivtv driver) while using my network card. If I disable
DMA on the disk and don't use my card, it's much more stable (several
hours without problem).

See this for more details:
http://forums.viaarena.com/messageview.aspx?catid=28&threadid=60131&enterthread=y

J
