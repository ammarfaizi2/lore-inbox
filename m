Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWGLMqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWGLMqb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 08:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWGLMqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 08:46:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52149 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751341AbWGLMqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 08:46:30 -0400
Subject: Re: [BUG] 2.6.18-rc1-mm1: as usual can not boot
From: Arjan van de Ven <arjan@infradead.org>
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060712121704.def30154.pauldrynoff@gmail.com>
References: <20060712095933.57d2a595.pauldrynoff@gmail.com>
	 <20060712001232.a31285e3.akpm@osdl.org>
	 <20060712113718.8e5e3af7.pauldrynoff@gmail.com>
	 <1152690358.3217.20.camel@laptopd505.fenrus.org>
	 <20060712121704.def30154.pauldrynoff@gmail.com>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 14:46:24 +0200
Message-Id: <1152708385.3217.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 12:17 +0400, Paul Drynoff wrote:
> On Wed, 12 Jul 2006 09:45:58 +0200
> Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > On Wed, 2006-07-12 at 11:37 +0400, Paul Drynoff wrote:
> > > On Wed, 12 Jul 2006 00:12:32 -0700
> > > Andrew Morton <akpm@osdl.org> wrote:
> > > 
> > > > On Wed, 12 Jul 2006 09:59:33 +0400
> > > > Paul Drynoff <pauldrynoff@gmail.com> wrote:
> > > > 
> > 
> > Hi, I havent followed your saga much, but in the past I've seen cases
> > where such kind of thing went away when AGP was set to be built into the
> > kernel, rather than as a module or not even built at all.
> > 
> > I don't know what your AGP setting is but if it's not built in it's
> > worth a shot to set it to be built in.
> > 
> 
> thanks for reply,
> 
> At now I build all in kernel (without modules) for debuging purposes,
> I have 
> $ grep -i AGP .config
> CONFIG_AGP=y
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_ATI is not set
> # CONFIG_AGP_AMD is not set
> # CONFIG_AGP_AMD64 is not set
> # CONFIG_AGP_INTEL is not set
> # CONFIG_AGP_NVIDIA is not set
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_SWORKS is not set
> # CONFIG_AGP_VIA is not set
> # CONFIG_AGP_EFFICEON is not set

please also turn on the AGP driver for the chipset you have ;)


