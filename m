Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281797AbSADVom>; Fri, 4 Jan 2002 16:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282213AbSADVoX>; Fri, 4 Jan 2002 16:44:23 -0500
Received: from smtp-ham-2.netsurf.de ([194.195.64.98]:62876 "EHLO
	smtp-ham-2.netsurf.de") by vger.kernel.org with ESMTP
	id <S281797AbSADVoO>; Fri, 4 Jan 2002 16:44:14 -0500
Date: Fri, 4 Jan 2002 22:40:07 +0100
From: Andreas Bombe <bombe@informatik.tu-muenchen.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system
Message-ID: <20020104214007.GA11072@storm.local>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020104014938.GA3474@storm.local> <24687.1010111468@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24687.1010111468@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 01:31:08PM +1100, Keith Owens wrote:
> On Fri, 4 Jan 2002 02:49:38 +0100, 
> Andreas Bombe <bombe@informatik.tu-muenchen.de> wrote:
> >Unionfs as I understand it would be great for editing/patching and
> >building.  Build a kernel in the pristine sources, mount a COW layer
> >over it where you patch/edit, build there.  In the ideal case the COW
> >layer would only build the changed file(s) and link vmlinux with all the
> >other objects from the pristine build.  This wouldn't affect the
> >pristine build itself at all, no make problems there when you remove the
> >COW build&change layer.
> 
> You are talking about removing an entire layer, I am talking about
> removing individual files when you decide the edit failed.  Removing
> the entire layer works, as long as all changes are always made to the
> top layer.  Removing individual files gets into timestamp problems.

Duh, you are right.  That can't be solved cleanly.

-- 
Andreas Bombe <bombe@informatik.tu-muenchen.de>    DSA key 0x04880A44
