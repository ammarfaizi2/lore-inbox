Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVBRQuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVBRQuv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 11:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVBRQuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 11:50:50 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:27373 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261404AbVBRQud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 11:50:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=soC67Rww+XnSreChVYEMKXoHLiiZOgPRkwQM6xJSkVnVLmHGE0iaFeGVkbaemqNJRmi9jMvDBEevNsVJUTlm5PjxI+QafIdJddasDLv1jf0z6pxcQnCIHMrvP5ln8FSnrw1XSQWXEaCX7U88edgMQj8YDYMtmUNlxAZ+MUDczbU=
Message-ID: <9e47339105021808507f778021@mail.gmail.com>
Date: Fri, 18 Feb 2005 11:50:29 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050218120914.GB31891@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502151557.06049.jbarnes@sgi.com>
	 <1108515817.13375.63.camel@gaston>
	 <200502161554.02110.jbarnes@sgi.com> <1108601294.5426.1.camel@gaston>
	 <9e473391050217083312685e44@mail.gmail.com>
	 <1108680350.5665.7.camel@gaston>
	 <9e473391050217145620fecfdc@mail.gmail.com>
	 <20050218120914.GB31891@iram.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005 13:09:14 +0100, Gabriel Paubert <paubert@iram.es> wrote:
> For example if it declares 128k, compare the two halves, reduce
> to 64k if equal. Lather, rinse, repeat.
> 
> It's equivalent to reading the BAR declared size twice in
> the worst case, so it's not that bad performance-wise.
> 
> That would only be in the case of an unknown signature
> in the first bytes, otherwise the third byte gives you
> the size IIUC.

The third byte size is wrong in too many cards to be useful. I have
always found the size in the PCIR header to be accurate.

> 
>         Gabriel
> 


-- 
Jon Smirl
jonsmirl@gmail.com
