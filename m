Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311869AbSCZNam>; Tue, 26 Mar 2002 08:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311881AbSCZNac>; Tue, 26 Mar 2002 08:30:32 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:28115 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S311869AbSCZNaS>;
	Tue, 26 Mar 2002 08:30:18 -0500
Date: Tue, 26 Mar 2002 14:29:55 +0100
From: David Weinehall <tao@acc.umu.se>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: save_flags() should take unsigned long
Message-ID: <20020326142955.E16636@khan.acc.umu.se>
In-Reply-To: <20020304184653.GA8646@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 07:46:53PM +0100, Pavel Machek wrote:
> Hi!
> 
> ...and here's patch to fix it... Please apply.

The correct way to fix this would be:

<in suitable header-file; suggestions welcome>
typedef flags_t unsigned long;

If someone can just come up with the proper header-file to use, I have
a patch that fixes up all (?) code.

My suggestion would be to keep the typedef in the same header-file as
save_flags/restore_flags.


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
