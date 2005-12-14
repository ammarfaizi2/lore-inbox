Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVLNLTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVLNLTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVLNLTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:19:06 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38828 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932418AbVLNLTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:19:04 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Paul Jackson <pj@sgi.com>, mingo@elte.hu, hch@infradead.org, akpm@osdl.org,
       torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <14242.1134558772@warthog.cambridge.redhat.com>
References: <13820.1134558138@warthog.cambridge.redhat.com>
	 <20051213143147.d2a57fb3.pj@sgi.com> <20051213094053.33284360.pj@sgi.com>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>
	 <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu>
	 <20051213100015.GA32194@elte.hu>
	 <6281.1134498864@warthog.cambridge.redhat.com>
	 <14242.1134558772@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Dec 2005 11:18:41 +0000
Message-Id: <1134559121.25663.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-12-14 at 11:12 +0000, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > 
> >  (6) Make wrappers for up/down that map to counting semaphores with the
> >      deprecation attribute set.
> 
>  (7) After a couple of months, remove up and down entirely.

Why bother. As has already been discussed up and down are the natural
and normal names for counting semaphores. You don't need to obsolete the
old API thats just silly, you need to add a new one and wait for people
to use it.

The old API is still very useful for some applications that want
counting semaphores.

