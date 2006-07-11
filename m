Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWGKNRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWGKNRL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWGKNRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:17:11 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:11580 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751052AbWGKNRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:17:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FXm9qJNonJQ4x1cnqJX4Bxc3t7aMt4JaLq2TeuTreu+4fLvCYFQdLzfMGbkm1nBHuqFdQEDKTXTXx+XfZID5+SXjfvB/wYySA5Vct9NwDB8wcd+XQ1YR1Ky7IVJS++iZdBuT6Ady3yoeejppvffWqC9zFTBBDBBzcDc9mAJTUw0=
Message-ID: <6bffcb0e0607110617g36f7123dm2b5f0e88b10cbcaa@mail.gmail.com>
Date: Tue, 11 Jul 2006 15:17:09 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0607110556v50185b9i5443dabedba46152@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110527x4520d5bbne8b9b3639a821a18@mail.gmail.com>
	 <b0943d9e0607110556v50185b9i5443dabedba46152@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > Unfortunately, it doesn't compile for me.
> >
> > make O=/dir
> > [..]
> > CC      arch/i386/kernel/alternative.o
> > {standard input}: Assembler messages:
> > {standard input}:1954: Error: can't resolve `.data' {.data section} -
> > `.Ltext0' {.text section}
>
> I don't get any error (and kmemleak doesn't touch this file). Is this
> with the 2.6.18-rc1 kernel?

It's a gcc 4.1 issue
gcc --version
gcc (GCC) 4.1.1 20060525 (Red Hat 4.1.1-1)

With gcc 3.4 it build.

>
> --
> Catalin
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
