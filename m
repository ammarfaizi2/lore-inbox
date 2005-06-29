Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVF2H7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVF2H7K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVF2H7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:59:09 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:59567 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262475AbVF2H6e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:58:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LTM3enhCEJzpO1etR6Agh9yt4JDmz8gJ1ajDCOYdWAQy91M6uFy2tyrzVTDh7ftBM5a0iU/SNq4xQ6QIhCEN+ZlT0/o2x03iesMpTPuR4uO7VUd9PuSpeVyiQWwLbMLwDHtKlAtG8EBO4CRAdIj37AEMWaUgAZrQZvC5GfYO2gY=
Message-ID: <84144f0205062900585a7e0d9f@mail.gmail.com>
Date: Wed, 29 Jun 2005 10:58:28 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH 2/3] freevxfs: minor cleanups
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2005.06.29.07.32.18.523132@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi>
	 <iit0h1.q7pnex.bkir3xysppdufw6d9h65boz37.refire@cs.helsinki.fi>
	 <20050628163114.6594e1e1.akpm@osdl.org>
	 <1120018821.9658.4.camel@localhost>
	 <pan.2005.06.29.07.32.18.523132@smurf.noris.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please don't trim the cc list when replying.)

Pekka Enberg wrote:
> > The rationale for this is that since NULL is not guaranteed to be zero
> > by the C standard

On 6/29/05, Matthias Urlichs <smurf@smurf.noris.de> wrote:
> ... as opposed to the other 632719 places in the kernel source where
> we do the exact same thing?

Well, as silly as it sounds to you, that _was_ the rationale for NTFS.
I actually like it better than using kcalloc() but at the end of the
day, I care more that the kernel uses same idioms all over. Makes the
code easier to understand for my tiny brain...

P.S. Those 632719 places can be fixed too with a handful of persistent
kernel janitors ;)

                               Pekka
