Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTKSG6h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 01:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263873AbTKSG6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 01:58:37 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:39042
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263871AbTKSG6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 01:58:36 -0500
Date: Wed, 19 Nov 2003 01:50:34 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: jon@jon-foster.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
In-Reply-To: <20031118214515.425dbe26.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0311190147060.11537@montezuma.fsmlabs.com>
References: <3FBAAFDF.5000803@jon-foster.co.uk>
 <Pine.LNX.4.53.0311182220570.11537@montezuma.fsmlabs.com>
 <20031118214515.425dbe26.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Nov 2003, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> >
> >  I've walked that code and can't see anything wrong anywhere.
> 
> fwiw, X comes up happily on a couple of boxes here, with the 4g/4g split
> enabled.

The exact same kernel runs fine on my other test boxes. But i really don't 
have faith in this compiler, it's the same one which constantly seems to be 
tripping into various problems.

> Have you tried a different compiler?

I just tried the RH9 2.96 and it also triple faulted. Oh my.. The only 
unique thing about this hardware compared ot the other stuff i have here 
is that it's an AMD K6. Everything else is Intel.

