Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267651AbRGNPZk>; Sat, 14 Jul 2001 11:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264952AbRGNPZa>; Sat, 14 Jul 2001 11:25:30 -0400
Received: from weta.f00f.org ([203.167.249.89]:25475 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267651AbRGNPZZ>;
	Sat, 14 Jul 2001 11:25:25 -0400
Date: Sun, 15 Jul 2001 03:25:28 +1200
From: Chris Wedgwood <cw@f00f.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu, linux-mm@kvack.org
Subject: Re: RFC: Remove swap file support
Message-ID: <20010715032528.E6722@weta.f00f.org>
In-Reply-To: <3B472C06.78A9530C@mandrakesoft.com> <m1elrk3uxh.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1elrk3uxh.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2001 at 12:07:38AM -0600, Eric W. Biederman wrote:

    Yes, and no.  I'd say what we need to do is update rw_swap_page to
    use the address space functions directly.  With block devices and
    files going through the page cache in 2.5 that should remove any
    special cases cleanly.

Will block devices go through the page cache in 2.5.x?

I had hoped they would, that any block devices would just be
page-cache views of underlying character devices, thus allowing us to
remove the buffer-cache and the /dev/raw stuff.



  --cw
