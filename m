Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbWBNMqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbWBNMqi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 07:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbWBNMqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 07:46:38 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:4847 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161040AbWBNMqh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 07:46:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kxGe3OP4l4/vWc5uGKNDMbcZcyuDiAB8gq1fbTZhIazTsE2ELhn84MnP17o6ny02zU0nsd6SV0LNlw4YGXxdbmZd90YLZPffW8gya40G+QVEhzHwKiHC03eoqK5GxPQ7qdf3CMKG9wcE2zDZLyODPXBHIqUvhRV2LT13o/cjERk=
Message-ID: <6bffcb0e0602140446i4c33d015y@mail.gmail.com>
Date: Tue, 14 Feb 2006 13:46:36 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: sander@humilis.net
Subject: Re: 2.6.16-rc3-mm1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       sam@ravnborg.org
In-Reply-To: <20060214121642.GA23915@favonius>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060214014157.59af972f.akpm@osdl.org>
	 <6bffcb0e0602140316sae62b9an@mail.gmail.com>
	 <20060214121642.GA23915@favonius>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/02/06, Sander <sander@humilis.net> wrote:
> Michal Piotrowski wrote (ao):
> > It's strange... rc3-mm1 vs. rc2-mm1
> >
> > :/usr/src/linux-mm$ uname -a
> > Linux ltg01-sid 2.6.16-rc2-mm1 #15 SMP PREEMPT Thu Feb 9 18:12:08 CET
> > 2006 i686 GNU/Linux
> >
> >
> > :/usr/src/linux-mm$ head Makefile
> > VERSION = 2
> > PATCHLEVEL = 6
> > SUBLEVEL = 16
> > EXTRAVERSION =-rc3-mm1
> >
> > there is something wrong with build system.
>
> You just booted an old kernel (see the date in your uname output).
>
>         Kind regards, Sander
>
> --
> Humilis IT Services and Solutions
> http://www.humilis.net
>

Ups...

But wait! It's my first -mm kernel on that box after system
reinstallation. uname contain my new hostname "ltg01-sid" - it's very
strange.

I will check my build script.

Regards,
Michal Piotrowski
