Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288276AbSAUVNH>; Mon, 21 Jan 2002 16:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288342AbSAUVM5>; Mon, 21 Jan 2002 16:12:57 -0500
Received: from dpt-info.u-strasbg.fr ([130.79.44.193]:36114 "EHLO
	dpt-info.u-strasbg.fr") by vger.kernel.org with ESMTP
	id <S288276AbSAUVMo>; Mon, 21 Jan 2002 16:12:44 -0500
Date: Mon, 21 Jan 2002 22:12:21 +0100
From: Sven <luther@dpt-info.u-strasbg.fr>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev fbgen cleanup
Message-ID: <20020121221221.A18731@dpt-info.u-strasbg.fr>
In-Reply-To: <20020121092851.A11531@dpt-info.u-strasbg.fr> <Pine.LNX.4.10.10201210849030.20645-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10201210849030.20645-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Mon, Jan 21, 2002 at 09:03:25AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 09:03:25AM -0800, James Simmons wrote:
> 
> As for the fbdev layer. Their was way to much code to cleanup and maintain
> in sync. So ruby had hardly any fbdev ported over :-( Now I'm spending the
> time to port every single fbdev driver over. Alot of work but it is
> needed.

Ahem, ...

If you would take a little bit of time to write some doc or ruby howto, maybe
you would not need to port them all by yourself ...

BTW, the matrox driver don't build on ruby + 2.5.1

> > BTW, romain, i have built pm3fb with 2.5.2, there were some modifications
> > needed, the major of them was the testing for 2.2 or 2.4 kernels that needed
> > changing, and the new info.node, which needed to be changed to
> > info.node.values.
> 
> The correct fix is to do something like fb_info.node = NODEV;

And not info.node.value = -1 ?

Ok, will do.

Friendly,

Sven Luther
