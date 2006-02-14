Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030530AbWBNNyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030530AbWBNNyz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 08:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWBNNyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 08:54:55 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:43422 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030530AbWBNNyy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 08:54:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EV9k0b/XBZ9wGPYAoQnE9TUvGH856AECo1w7BbSKlb2dTijiF5MPAKXMi/QycYmN7/c20ZBtfPBFDbO6L50GMUEcZjnunh+oqgpruLxGz/4fzw/Dyt7EBZa/FcfhodehfJWLtAPj5UJ6TlFCNWZG7WdKy4u0wwrHlnZo4LRvSc4=
Message-ID: <6bffcb0e0602140554j56d5a95bi@mail.gmail.com>
Date: Tue, 14 Feb 2006 14:54:53 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.16-rc3-mm1: i386 compilation broken
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200602141427.49763.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060214014157.59af972f.akpm@osdl.org>
	 <20060214131715.GA10701@stusta.de> <200602141427.49763.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/02/06, Andi Kleen <ak@suse.de> wrote:
> On Tuesday 14 February 2006 14:17, Adrian Bunk wrote:
> > On Tue, Feb 14, 2006 at 01:41:57AM -0800, Andrew Morton wrote:
> > >...
> > > Changes since 2.6.16-rc2-mm1:
> > >...
> > > +x86_64-fix-string.patch
> > >...
> > >  x86_64 tree updates.
> > >...
> >
> > This patch breaks the compilation on i386:
>
> Ok then the -ffreestanding was apparently still needed on other architectures too.
> I guess that part of the patch can be just dropped.
>
> Andrew can you drop that please?
>
> -Andi

Thanks, problem solved!

Andrew can you add this to hot-fixes?

Regards,
Michal Piotrowski
