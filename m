Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284444AbRLCIvg>; Mon, 3 Dec 2001 03:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284400AbRLCIuX>; Mon, 3 Dec 2001 03:50:23 -0500
Received: from dsl-213-023-038-056.arcor-ip.net ([213.23.38.56]:61707 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284474AbRLCAFs>;
	Sun, 2 Dec 2001 19:05:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Nathan Scott <nathans@sgi.com>, Alexander Viro <viro@math.psu.edu>,
        Andi Kleen <ak@suse.de>, Andreas Gruenbacher <ag@bestbits.at>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC][PATCH] VFS interface for extended attributes
Date: Mon, 3 Dec 2001 01:07:13 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.21.0111121152410.14344-100000@moses.parsec.at> <20011114230134.A5739@lynx.no> <20011116101800.A632931@wobbly.melbourne.sgi.com>
In-Reply-To: <20011116101800.A632931@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Agdh-0000BS-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, sorry for jumping into this a little late, but...

On November 16, 2001 12:18 am, Nathan Scott wrote:
> > What is the distinction between "set" and "replace" or "set" and "create"?
> 
> +#define EA_CREATE   0x0001  /* Set the value: fail if attr already exists */
> +#define EA_REPLACE  0x0002  /* Set the value: fail if attr does not exist */
> 
> Whereas "set" is simply set the named attribute value, creating the
> attribute if need be, replacing the value if the attribute exists,
> and then return success.

What is the purpose of these distinctions?  Does anyone rely on them?  Do such
distinctions exist in an existing implementation?

Thanks.

Daniel

