Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbTAVTK0>; Wed, 22 Jan 2003 14:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbTAVTK0>; Wed, 22 Jan 2003 14:10:26 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54022 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262384AbTAVTKY>; Wed, 22 Jan 2003 14:10:24 -0500
Date: Wed, 22 Jan 2003 14:16:19 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Olaf Titz <olaf@bigred.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16 
In-Reply-To: <10554.1043234338@passion.cambridge.redhat.com>
Message-ID: <Pine.LNX.3.96.1030122133330.3958B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, David Woodhouse wrote:

> 
> olaf@bigred.inka.de said:
> >  Only for stand-alone machines which only ever compile and run one
> > kernel. You don't need a data center to violate that, you just need
> > the fairly usual three-boxes home network (one of which is mainly a
> > router/firewall which has no development environment if only for
> > security reasons, or because it's a scavenged '486). 
> 
> Er, if it has no development environment, why are you bitching about the 
> fact that it's not possible to compile kernel modules on it?
> 
> The box which holds your firewall's kernel source can be used to compile 
> extra out-of-tree modules. The directory /lib/modules/`uname -r`/build, 
> while a reasonable _default_ for out-of-tree modules to use, should 
> generally be overridable with a directory specified by yourself.

`uname -r` is the kernel version of the running kernel. It is NOT by magic
the kernel version of the kernel you are building... 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

