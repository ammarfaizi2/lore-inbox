Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267177AbSLKOqg>; Wed, 11 Dec 2002 09:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbSLKOqB>; Wed, 11 Dec 2002 09:46:01 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:1939 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267176AbSLKOp7>; Wed, 11 Dec 2002 09:45:59 -0500
Date: Wed, 11 Dec 2002 07:46:43 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Antonino Daplas <adaplas@pol.net>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: atyfb in 2.5.51
In-Reply-To: <1039610834.1084.106.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0212110745500.2617-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Before, most drivers just unconditionally refresh the hardware at every
> switch  during set_var(). I've been pointing this out for a long time
> now, do we unconditionally do a check_var()/set_par() after every
> console switch, or do we rely on fbdev and X cooperating with each
> other? Or better, maybe fbcon has a way of knowing if the switch came
> from  Xfree86.

My next project is to fix this issue. I will be working on that today.


