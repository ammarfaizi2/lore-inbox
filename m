Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbTBQEAA>; Sun, 16 Feb 2003 23:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266716AbTBQEAA>; Sun, 16 Feb 2003 23:00:00 -0500
Received: from crack.them.org ([65.125.64.184]:41149 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S266686AbTBQD77>;
	Sun, 16 Feb 2003 22:59:59 -0500
Date: Sun, 16 Feb 2003 23:09:49 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Rahul Vaidya <rahulv@csa.iisc.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling
Message-ID: <20030217040949.GA10986@nevyn.them.org>
Mail-Followup-To: Rahul Vaidya <rahulv@csa.iisc.ernet.in>,
	linux-kernel@vger.kernel.org
References: <20030217035821.GA10759@nevyn.them.org> <Pine.SOL.3.96.1030217093109.27688D-100000@osiris.csa.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.3.96.1030217093109.27688D-100000@osiris.csa.iisc.ernet.in>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 09:33:32AM +0530, Rahul Vaidya wrote:
> >From my kernel source directory: I have aliased gcc to my actual gcc
> file..not the softlinked one..

Shell aliases won't affect the GCC that Make uses.  Try using make
CC=/path/to/real/gcc.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
