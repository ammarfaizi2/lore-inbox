Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270964AbRHXIKB>; Fri, 24 Aug 2001 04:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270957AbRHXIJv>; Fri, 24 Aug 2001 04:09:51 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:62224 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S270948AbRHXIJu> convert rfc822-to-8bit; Fri, 24 Aug 2001 04:09:50 -0400
Date: Fri, 24 Aug 2001 10:10:03 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010824101003.A16057@emma1.>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010822030807.N120@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010822030807.N120@pervalidus>; from 0@pervalidus.net on Wed, Aug 22, 2001 at 03:08:07AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Frédéric L. W. Meunier wrote:

> Am I the only one afraid that the Python requirement can turn
> into a problem ? You can develop anything on Linux without
> Python. I'd compare Python to Tcl - you only install it to
> waste space, develop, or run applications that use it. Perl
> is very different. It's required by GNU Automake and more.

But you only install it to waste space, develop, or run applications
that use it. What's the difference?

> I'm really surprised by the fact that nobody noticed what a
> nightmare 2.6 will be with such a requirement. You can't
> expect everybody to install something that's of no use for
> most.

You'd expect distributors to ship a Python version that's suited for
Kernel configuration by then. If they don't, well, get another
distribution.

> My intention isn't to diminish the importance of CML2 and the
> hard and volunteer work of Eric S. Raymond. I just can't
> consider Python a requirement to configure the build process
> of a Kernel.

Why not? You expect people to have a not-too recent GCC, GNU make and
other tools, so why not Python?

Of course, a standalone code that'd run out of C would be fine, but if
that comes with less maintainability or would be more difficult to
maintain, there's nothing to be gained.

Is there a py2c compiler? If so, it might be useful if kernel.org
carried a compiled version of CML2, if at all possible.

But I feel there's no need to whine about 2.6. Enough time for
distributors to ship their distributions with Python 2.x.1 and for
distributors or third parties to package Python2 for older distribution
releases.

The only valid point might be "embedded systems", but then again, you
should be able to cross compile the kernel for your embedded system for
fun and for speed.

Regards,
Matthias Andree
