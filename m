Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288456AbSADCbl>; Thu, 3 Jan 2002 21:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288457AbSADCbc>; Thu, 3 Jan 2002 21:31:32 -0500
Received: from zok.SGI.COM ([204.94.215.101]:38068 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S288456AbSADCbV>;
	Thu, 3 Jan 2002 21:31:21 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andreas Bombe <bombe@informatik.tu-muenchen.de>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Fri, 04 Jan 2002 02:49:38 BST."
             <20020104014938.GA3474@storm.local> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 04 Jan 2002 13:31:08 +1100
Message-ID: <24687.1010111468@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002 02:49:38 +0100, 
Andreas Bombe <bombe@informatik.tu-muenchen.de> wrote:
>Unionfs as I understand it would be great for editing/patching and
>building.  Build a kernel in the pristine sources, mount a COW layer
>over it where you patch/edit, build there.  In the ideal case the COW
>layer would only build the changed file(s) and link vmlinux with all the
>other objects from the pristine build.  This wouldn't affect the
>pristine build itself at all, no make problems there when you remove the
>COW build&change layer.

You are talking about removing an entire layer, I am talking about
removing individual files when you decide the edit failed.  Removing
the entire layer works, as long as all changes are always made to the
top layer.  Removing individual files gets into timestamp problems.

