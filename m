Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264851AbSJOVGX>; Tue, 15 Oct 2002 17:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264852AbSJOVFm>; Tue, 15 Oct 2002 17:05:42 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:7059 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S264851AbSJOVFV>;
	Tue, 15 Oct 2002 17:05:21 -0400
Date: Tue, 15 Oct 2002 23:11:03 +0200
From: David Weinehall <tao@acc.umu.se>
To: Fernando Alencar =?iso-8859-1?Q?Mar=F3stica?= <famarost@unimep.br>
Cc: fadel@ferasoft.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.0] Fixed kernel stuff
Message-ID: <20021015211103.GV26715@khan.acc.umu.se>
References: <1034548634.543.1.camel@nitrogenium> <20021014220527.GU26715@khan.acc.umu.se> <1034708558.427.0.camel@nitrogenium>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1034708558.427.0.camel@nitrogenium>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 05:02:37PM -0200, Fernando Alencar Maróstica wrote:
> Hello all, specially David 
> 
> I think this patch is trivial enough to be accepted, but...
> 
> This patch fixed some stuff:
> 	* Fixed warning in script/lxdialog/menubox.c
> 	* Fixed warning in script/lxdialog/textbox.c
> 	* Small VM updates ...

Since you are doing changes to the VM, I would like detail descriptions
of what each change does, and why it is necessary, stability- or
security-wise. I will not accept changes to the VM subsystem unless
there is a valid reason; let the early v2.4-series be witness to why
this is a good stance.

Speedups are generally not counted as a valid reason, unless we're
talking a change in the order of a magnitude or more. Code cleanup
might be a good reason, but then I'll merge it into the 2.0.41-tree
instead; this will probably be the case for your lxdialog-fixes, since
I'm cleaning up that code anyway for 2.0.41.


Regards: David Weinehall
-- 
 /> David Weinehall <tao@acc.umu.se> /> Northern lights wander      <\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
