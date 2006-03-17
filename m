Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWCQPon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWCQPon (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 10:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbWCQPon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 10:44:43 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:30833 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030194AbWCQPon convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 10:44:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZolQZzjatSJKLDX/gy17brCT0tTBZo3v+SX1Y7bUioUcmT83CeddxsQVkKhaLnr39N5zsimDT6IPTbeK6NbB6cEg1a8cnw8hdULsuI2cBgW/iLwH7ERBnKIQlT+hsjtgLsx9UgrNH6ggnaAqkliKDDtGq+4DFrlxf4JAzgUFSOA=
Message-ID: <6bffcb0e0603170744lb17b661x@mail.gmail.com>
Date: Fri, 17 Mar 2006 16:44:12 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.16-rc6-rt3
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060317135029.GA4007@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060314084658.GA28947@elte.hu> <4416C6DD.80209@cybsft.com>
	 <20060314142458.GA21796@elte.hu> <4416F14E.1040708@cybsft.com>
	 <20060317092351.GA18491@elte.hu>
	 <6bffcb0e0603170532r664142a4w@mail.gmail.com>
	 <20060317135029.GA4007@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> > Something goes wrong.
> >
> > make
> > [..]
> >   LD [M]  lib/zlib_inflate/zlib_inflate.o
> >   LD      arch/i386/lib/built-in.o
> >   CC      arch/i386/lib/bitops.o
> > {standard input}: Assembler messages:
> > {standard input}:429: Error: can't resolve `.sched.text' {.sched.text
> > section} - `.Ltext0' {.text section}
>
> hm, cannot reproduce that build problem here, with your config and with:
>
>  gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)
>
>         Ingo
>

It looks like a gcc 4.1.0 regression.
gcc 4.0.3 (Debian 4.0.3-1) works good.

Can you check it on gcc 4.1 from Fedora?

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
