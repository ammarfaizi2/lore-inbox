Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288946AbSAFNZk>; Sun, 6 Jan 2002 08:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288949AbSAFNZ2>; Sun, 6 Jan 2002 08:25:28 -0500
Received: from ns.suse.de ([213.95.15.193]:60420 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288948AbSAFNZW>;
	Sun, 6 Jan 2002 08:25:22 -0500
Date: Sun, 6 Jan 2002 14:25:17 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Momchil Velikov <velco@fadata.bg>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove 8 bytes from struct page on 64bit archs
In-Reply-To: <87n0zraagg.fsf@fadata.bg>
Message-ID: <Pine.LNX.4.33.0201061421400.3859-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jan 2002, Momchil Velikov wrote:

> They're pretty much independent of each other

Hardly. wli removes the zone ptr completely by encoding it into flags,
whilst anton makes it conditional. As it stands, they don't
play together.

> as a single large dropping^h^h^h^h is not the preferred way of
> submitting patches.

They both have the same (or similar) goal. Having them both go
off in different directions to achieve that goal is counterproductive
if the end result is the same.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

