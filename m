Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbTBQDhR>; Sun, 16 Feb 2003 22:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266368AbTBQDhR>; Sun, 16 Feb 2003 22:37:17 -0500
Received: from crack.them.org ([65.125.64.184]:35517 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S266330AbTBQDhQ>;
	Sun, 16 Feb 2003 22:37:16 -0500
Date: Sun, 16 Feb 2003 22:46:44 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Rahul Vaidya <rahulv@csa.iisc.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling
Message-ID: <20030217034644.GA10083@nevyn.them.org>
Mail-Followup-To: Rahul Vaidya <rahulv@csa.iisc.ernet.in>,
	linux-kernel@vger.kernel.org
References: <20030216182512.GB4861@nevyn.them.org> <Pine.SOL.3.96.1030217085753.27558A-100000@osiris.csa.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.3.96.1030217085753.27558A-100000@osiris.csa.iisc.ernet.in>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 09:03:30AM +0530, Rahul Vaidya wrote:
> The command ./gcc -v -iwithprefix include -E - < /dev/null
> from the directory containing the actual gcc file.
> 
> Reading specs from ./../lib/gcc-lib/i686-pc-linux-gnu/3.2/specs
> Configured with: ../gcc-3.2/configure --prefix=/usr/local/gcc-3.2

>  ../lib/gcc-lib/i686-pc-linux-gnu/3.2/include

And isn't that the right directory?  Try building a kernel this way.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
