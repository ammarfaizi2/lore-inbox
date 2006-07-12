Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWGLKt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWGLKt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 06:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWGLKt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 06:49:57 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:65509 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751247AbWGLKt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 06:49:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jSZeLe7WNFRZFnd1/uTdd5iB2gt9PvTysTTAN+76lJzQTMEuvnOrY5HNpb8wquxi4S/tSb70ruKbHY9ciRGNsJC2mHi1i/KEUD8gwzT2yGwCtO46hbxSEoAW0ZhzoYpQeDEu+vEfEOhOv0/VwvqkBgAZrKVFLM5nlX4lVe9fdtw=
Message-ID: <6bffcb0e0607120349s7fd194e1xf92f194ebcd17d9f@mail.gmail.com>
Date: Wed, 12 Jul 2006 12:49:56 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: "Joseph Fannin" <jfannin@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0607120338r37886ebck56db5fbf29e8e350@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110527x4520d5bbne8b9b3639a821a18@mail.gmail.com>
	 <6bffcb0e0607110546r11d2f619pbcd1205999253bd@mail.gmail.com>
	 <6bffcb0e0607110551v272deebcua5dc3f782ed25a7f@mail.gmail.com>
	 <b0943d9e0607110600q345b5ad7y38174b85cf01edba@mail.gmail.com>
	 <20060712095730.GA19478@nineveh.rivenstone.net>
	 <b0943d9e0607120338r37886ebck56db5fbf29e8e350@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 12/07/06, Joseph Fannin <jfannin@gmail.com> wrote:
> > On Tue, Jul 11, 2006 at 02:00:05PM +0100, Catalin Marinas wrote:
> > > That's a bug in gcc-4. The __builtin_constant_p() function always
> > > returns true even when the argument is not a constant. You could try a
> > > gcc-3.4 or a patched gcc.
> >
> >     Which gcc versions are affected by this?
>
> From gcc-4.0 I think but I don't know when/if it was fixed in the
> latest.

gcc-4.2 --version
gcc-4.2 (GCC) 4.2.0 20060701 (experimental)

works fine for me.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
