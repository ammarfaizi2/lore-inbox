Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272229AbRHWMKp>; Thu, 23 Aug 2001 08:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272244AbRHWMKf>; Thu, 23 Aug 2001 08:10:35 -0400
Received: from pk.nord-com.net ([213.168.202.34]:5369 "EHLO pk.nord-com.de")
	by vger.kernel.org with ESMTP id <S272229AbRHWMKU>;
	Thu, 23 Aug 2001 08:10:20 -0400
Date: Thu, 23 Aug 2001 14:05:55 +0200
From: Roland Bauerschmidt <rb@debian.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010823140555.A1077@newton.bauerschmidt.eu.org>
Mail-Followup-To: Roland Bauerschmidt <rb@debian.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010822030807.N120@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010822030807.N120@pervalidus>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fr?d?ric L. W. Meunier wrote:
> Am I the only one afraid that the Python requirement can turn
> into a problem ? You can develop anything on Linux without
> Python. I'd compare Python to Tcl - you only install it to
> waste space, develop, or run applications that use it. Perl
> is very different. It's required by GNU Automake and more.
> 
> I'm really surprised by the fact that nobody noticed what a
> nightmare 2.6 will be with such a requirement. You can't
> expect everybody to install something that's of no use for
> most.

Well, I don't know the details of the plans, but IMHO is a dependency to
python for configuring the kernel not unreasonable. Nowadays a lot of
people don't even compile their kernels themselves, and thus not
_everybody_ is required to have python installed. When using make
menuconfig you are also required to have curses development files
installed even if you don't need them for anything else. Python also is
of (fast) growing popularity, and for example in Debian (I don't know
about other distributions, but I suppose it's similar there) Python is
Priority: standard (whereas libncurses5-dev surely isn't). 

You my 0.02$, Roland

-- 
Roland Bauerschmidt
