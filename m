Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311169AbSCHV73>; Fri, 8 Mar 2002 16:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311168AbSCHV7U>; Fri, 8 Mar 2002 16:59:20 -0500
Received: from adsl-209-233-33-110.dsl.snfc21.pacbell.net ([209.233.33.110]:33519
	"EHLO lorien.emufarm.org") by vger.kernel.org with ESMTP
	id <S311165AbSCHV7K>; Fri, 8 Mar 2002 16:59:10 -0500
Date: Fri, 8 Mar 2002 13:59:08 -0800
From: Danek Duvall <duvall@emufarm.org>
To: J Sloan <jjs@lexus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: root-owned /proc/pid files for threaded apps?
Message-ID: <20020308215908.GB886@lorien.emufarm.org>
Mail-Followup-To: Danek Duvall <duvall@emufarm.org>,
	J Sloan <jjs@lexus.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020307060110.GA303@lorien.emufarm.org> <E16iyBW-0002HP-00@the-village.bc.nu> <20020308100632.GA192@lorien.emufarm.org> <20020308195939.A6295@devcon.net> <20020308203157.GA457@lorien.emufarm.org> <20020308222942.A7163@devcon.net> <3C893171.2050003@lexus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C893171.2050003@lexus.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 01:47:29PM -0800, J Sloan wrote:

> Andreas Ferber wrote:
> 
> >As a side note, IMHO it would be sensible to have some way of
> >disabling module autoloading of protocol modules in the network stack.
> >
> 
> What is the problem with using modules.conf e.g.
> 
> alias net-pf-10 off

I have that.  The problem is that if every time a program attempts to
make an IPv6 connection it forces the kernel to spawn off modprobe to go
look for it, you have a performance issue.  Of course, I'd imagine that
a reasonably written program would not try to use IPv6 beyond the first
failure.

Danek
