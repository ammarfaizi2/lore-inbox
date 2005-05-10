Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVEJPee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVEJPee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVEJPeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:34:25 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:33038
	"HELO linuxace.com") by vger.kernel.org with SMTP id S261686AbVEJPeK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:34:10 -0400
Date: Tue, 10 May 2005 08:34:07 -0700
From: Phil Oester <kernel@linuxace.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NMI lockup
Message-ID: <20050510153407.GA28833@linuxace.com>
References: <20050427212643.GA20483@linuxace.com> <20050429141543.3919fdfd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429141543.3919fdfd.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 02:15:43PM -0700, Andrew Morton wrote:
> Phil Oester <kernel@linuxace.com> wrote:
> >
> > Trying to update from 2.6.10 to 2.6.11 on a gateway, and keep
> >  getting an NMI lockup:
> > 
> >  NMI Watchdog detected LOCKUP on CPU1, eip c026a8d4, registers:
> >  CPU:    1
> >  EIP:    0060:[<c026a8d4>]    Not tainted VLI
> >  EFLAGS: 00001482   (2.6.11) 
> >  EIP is at fib_sync_down+0x74/0x140
> 
> This is believed to be fixed in current kernels.  Please retest 2.6.12-rc4
> or 2.6.12-rc3-mm1 (neither are released yet) and let us know if the problem
> is still there?

Tested 2.6.12-rc4, and had same problem, although I was unable to capture
the panic output.

Phil
