Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWB1KaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWB1KaY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWB1KaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:30:23 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:56977 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932156AbWB1KaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:30:21 -0500
Date: Tue, 28 Feb 2006 11:30:10 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: David Greaves <david@dgreaves.com>
cc: gcoady@gmail.com, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in
 warnings
In-Reply-To: <4402F6E7.3050500@dgreaves.com>
Message-ID: <Pine.LNX.4.61.0602281127480.9696@scrub.home>
References: <200602261721.17373.jesper.juhl@gmail.com>
 <336402hq8014pc1cg8169f8tumhj302vho@4ax.com> <4402F6E7.3050500@dgreaves.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 27 Feb 2006, David Greaves wrote:

> >Welcome to the club ;)  I gave up make randconfig months ago as 
> >there's simply too much noise in there...  There are same errors 
> >popping up for months now without resolution, and I lack experience 
> >to fix most things I see -- asked akpm once but not grok Andrew's 
> >response (months ago).
> >  
> >
> How about introducing an 'overlay' config that is introduced after
> randconfig runs?
> 
> That gives you the ability to, for example, always set
> 
> CONFIG_EMBEDDED=n

That exists already, just put it into allrandom.config. :)

bye, Roman
