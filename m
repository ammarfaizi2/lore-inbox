Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278735AbRJVLwt>; Mon, 22 Oct 2001 07:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278744AbRJVLwj>; Mon, 22 Oct 2001 07:52:39 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:12560 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278735AbRJVLw2>;
	Mon, 22 Oct 2001 07:52:28 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12 
In-Reply-To: Your message of "Mon, 22 Oct 2001 07:33:37 -0400."
             <Pine.GSO.4.21.0110220724120.2294-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Oct 2001 21:52:49 +1000
Message-ID: <26057.1003751569@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001 07:33:37 -0400 (EDT), 
Alexander Viro <viro@math.psu.edu> wrote:
>I suspect that in this case s/2.5/2.4-ac/ might be a possibility.  Since
>we are talking about defaults, nothing is going to break if file simply
>doesn't exist.  So teaching modprobe to handle it if it's there would
>be a compatible change and would allow testing the kernel side of that
>stuff.  Alan?

Do you really want modules exhibiting different behaviour in Linus and
-ac kernels?  And have that behaviour depending on which version of
modutils the user installed?  Not in 2.4, modutils strives for
stability in production kernels, it is an important interface between
the kernel and user space.

