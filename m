Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbWAJUdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWAJUdN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbWAJUdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:33:13 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:65111 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932570AbWAJUdM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:33:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jieoAXgq96YPFX++bqeswZHKmgmOlSlFOTsXDc9p9BIQQY0Btk3F1CFxdHymbGPBcYiRviaADepn4LrLFAjytiMk77L459+DCrQcT/r0/7RE2RpjGE0H6yIZV1y+XIz9897x5OGkpgGPgjkpmFU9Pkm7NxI6ULzag7q0qHy2NKQ=
Message-ID: <46a038f90601101233h5def4840k315be9520796b5e@mail.gmail.com>
Date: Wed, 11 Jan 2006 09:33:11 +1300
From: Martin Langhoff <martin.langhoff@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: git pull on Linux/ACPI release tree
Cc: Linus Torvalds <torvalds@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
In-Reply-To: <20060110201909.GB3911@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
	 <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org>
	 <20060108230611.GP3774@stusta.de>
	 <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org>
	 <20060110201909.GB3911@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/06, Adrian Bunk <bunk@stusta.de> wrote:
> I am using the workaround of carrying the patches in a mail folder,
> applying them in a batch, and not pulling from your tree between
> applying a batch of patches and you pulling from my tree.

In that case, there's a mostly automated way of doing that if you read
the last couple lines of git-rebase, using something along the lines
of

      git-format-patch <yours> <linus> | git-am -3 -k

> I'd say the main problem is that git with several other projects like
> cogito and stg on top of it allow many different workflows. But finding
> the one that suits one's needs without doing something in a wrong way
> is non-trivial.

You are right about that, but much of the space (of what workflows are
interesting) is still being explored, and git and the porcelains
reacting to people's interests. So it's still a moving target. A fast
moving target.

cheers,


martin
