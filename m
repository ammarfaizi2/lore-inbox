Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313091AbSC0Tz1>; Wed, 27 Mar 2002 14:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313092AbSC0TzS>; Wed, 27 Mar 2002 14:55:18 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:52075 "EHLO
	euler24.homenet") by vger.kernel.org with ESMTP id <S313091AbSC0TzE>;
	Wed, 27 Mar 2002 14:55:04 -0500
Date: Wed, 27 Mar 2002 19:52:18 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@euler24.homenet>
To: Eric Sandeen <sandeen@sgi.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] kmem_cache_zalloc
In-Reply-To: <1017257958.16305.168.camel@stout.americas.sgi.com>
Message-ID: <Pine.LNX.4.33.0203271949230.32307-100000@euler24.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Mar 2002, Eric Sandeen wrote:
> XFS adds a kmem_cache_zalloc function to mm/slab.c, it does what you
> might expect:  kmem_cache_alloc + memset

Useful. However, when I suggested, similarly, a kzalloc() to match
kmalloc() people loudly objected that "it is non-standard" (as if kmalloc
was "standard" in some sense :)
I wonder if they (I can't remember who it was) will say
"kmem_cache_zalloc is a non-standard name"...

Regards,
Tigran

