Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290423AbSAXWen>; Thu, 24 Jan 2002 17:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290422AbSAXWee>; Thu, 24 Jan 2002 17:34:34 -0500
Received: from tapu.cryptoapps.com ([63.108.153.39]:37817 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S290421AbSAXWeZ>;
	Thu, 24 Jan 2002 17:34:25 -0500
Date: Thu, 24 Jan 2002 14:33:25 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020124223325.GA886@tapu.f00f.org>
In-Reply-To: <3C5047A2.1AB65595@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C5047A2.1AB65595@mandrakesoft.com>
User-Agent: Mutt/1.3.26i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 12:42:58PM -0500, Jeff Garzik wrote:

    A small issue...

Which has spawn a bug ugly thread filled with opinions and other stuff
hardly relevant :)

    C99 introduced _Bool as a builtin type.  The gcc patch for it went
    into cvs around Dec 2000.  Any objections to propagating this type
    and usage of 'true' and 'false' around the kernel?

It seems everyone is discussing code efficiency and such like.... How
about we just assume that whether we use if(bool) or if(int) the
compiler produces euqally good and bad code --- I see no evidence to
suggest otherwise.

I don't want to argue over correctness here, too many people already
have.

Surely what is left to discuss was Jeff's original email --- do people
mind the use of this, does it make the source mode readable?

Arguably, I think it does.  It certainly doesn't make it less
readable.



  --cw
