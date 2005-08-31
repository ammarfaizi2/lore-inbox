Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbVHaWMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbVHaWMG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbVHaWMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:12:05 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:64357 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964909AbVHaWMC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:12:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NqDXFTo7ksvr1w1RVNb0UrOdMJB3HVVyTZ54QwvjJDMQVl0ukms3r8CYlPCtp58R2PtVSfmh5AHZHZX7sJs0GlRXxdZqk4bgYtMsQIcqf6dU/Qd04eaFROHtsBC9DoYTS9jYORt9ECTsFXV5KlPbEaXugADYv9zaXWMZQZdWB2M=
Message-ID: <9a874849050831151230d68d64@mail.gmail.com>
Date: Thu, 1 Sep 2005 00:12:00 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Andrew Morton <akpm@osdl.org>, SYSLINUX@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050831220717.GA14625@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com>
	 <20050831215757.GA10804@taniwha.stupidest.org>
	 <431628D5.1040709@zytor.com>
	 <20050831220717.GA14625@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/05, Chris Wedgwood <cw@f00f.org> wrote:
> On Wed, Aug 31, 2005 at 03:01:57PM -0700, H. Peter Anvin wrote:
> 
> > Maybe not.  Another option would simply be to bump it up
> > significantly (2x isn't really that much.)  4096, maybe.
> 
> I wonder if we're not at the point where we need something different
> to what we have now.  The concept of a command-line works for passing
> simple state but for more complex things it's too cumbersome.

How about

a) bump the limit on the cmd line - it's still useful, and 256 really
is quite small for some things.

b) add a new boot option telling the kernel the name of some file in
initrd or similar from which to load additional options.

I don't know if b is feasible at all. It would mean that the kernel
would need to get a hold of the initrd or whatever quite early to be
able to process options from it, but if it's doable somehow it would
be a really neat thing.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
