Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289342AbSAOBGW>; Mon, 14 Jan 2002 20:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289344AbSAOBGN>; Mon, 14 Jan 2002 20:06:13 -0500
Received: from zok.SGI.COM ([204.94.215.101]:22162 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S289338AbSAOBGD>;
	Mon, 14 Jan 2002 20:06:03 -0500
Date: Mon, 14 Jan 2002 17:02:25 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: memory-mapped i/o barrier
Message-ID: <20020114170225.A800421@sgi.com>
Mail-Followup-To: Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020110134859.A729245@sgi.com> <20020114062454.GA18794@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114062454.GA18794@krispykreme>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 05:24:54PM +1100, Anton Blanchard wrote:
> Can loads/stores also complete out of order to IO? (the example just shows
> a store from one cpu passing one from another cpu)

I'm not sure what you mean, do you have an example?

> On ppc32/ppc64 this can happen, it is fixed up in the low level pci
> routines. Is there a case where you cant wrap it up in the low level
> routines like ppc32/ppc64?

You mean in each outX routine you essentially do an mmiob()?

Jesse
