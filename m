Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWGLOm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWGLOm1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 10:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWGLOm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 10:42:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:38454 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751250AbWGLOm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 10:42:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=f44TlF8WJk6mRnjviE5/fCA2wJ987axxNBs8Rf2Svbegp5GQa83bjLDUHmXCR0UmmCOwelMkD1QBXXm7jCNFa5nu2tQWL+tuHcdwCT6AIo4PT0uBrY7D5pqXuFr0JEcwONI1vXlLg2nUUjzipzQJ4qlz/znEFit3u/kmc25Uxlk=
Date: Wed, 12 Jul 2006 18:28:21 +0400
From: Paul Drynoff <pauldrynoff@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.18-rc1-mm1: as usual can not boot
Message-Id: <20060712182821.96ca8830.pauldrynoff@gmail.com>
In-Reply-To: <1152708385.3217.34.camel@laptopd505.fenrus.org>
References: <20060712095933.57d2a595.pauldrynoff@gmail.com>
	<20060712001232.a31285e3.akpm@osdl.org>
	<20060712113718.8e5e3af7.pauldrynoff@gmail.com>
	<1152690358.3217.20.camel@laptopd505.fenrus.org>
	<20060712121704.def30154.pauldrynoff@gmail.com>
	<1152708385.3217.34.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 14:46:24 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

> On Wed, 2006-07-12 at 12:17 +0400, Paul Drynoff wrote:
> > On Wed, 12 Jul 2006 09:45:58 +0200
> > Arjan van de Ven <arjan@infradead.org> wrote:
> > 
> > > On Wed, 2006-07-12 at 11:37 +0400, Paul Drynoff wrote:
> > > > On Wed, 12 Jul 2006 00:12:32 -0700
> > > > Andrew Morton <akpm@osdl.org> wrote:
> > > > 
> > > > > On Wed, 12 Jul 2006 09:59:33 +0400
> > > > > Paul Drynoff <pauldrynoff@gmail.com> wrote:
> > > > > 
> > > 
> > > Hi, I havent followed your saga much, but in the past I've seen cases
> > > where such kind of thing went away when AGP was set to be built into the
> > > kernel, rather than as a module or not even built at all.
> > > 
> > > I don't know what your AGP setting is but if it's not built in it's
> > > worth a shot to set it to be built in.
> > > 
> > 
> > thanks for reply,
> > 
> > At now I build all in kernel (without modules) for debuging purposes,
> > I have 
> > $ grep -i AGP .config
> > CONFIG_AGP=y
> > # CONFIG_AGP_ALI is not set
> > # CONFIG_AGP_ATI is not set
> > # CONFIG_AGP_AMD is not set
> > # CONFIG_AGP_AMD64 is not set
> > # CONFIG_AGP_INTEL is not set
> > # CONFIG_AGP_NVIDIA is not set
> > # CONFIG_AGP_SIS is not set
> > # CONFIG_AGP_SWORKS is not set
> > # CONFIG_AGP_VIA is not set
> > # CONFIG_AGP_EFFICEON is not set
> 
> please also turn on the AGP driver for the chipset you have ;)
> 
> 

Actually when I boot on real machine all of them were turn on,

I don't see any sense turn on it when I use `qemu',
with such config I can boot succesefully on qemu with 2.6.18-rc1,
but can not with 2.6.18-rc1-mm1. 
