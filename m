Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290715AbSARPL3>; Fri, 18 Jan 2002 10:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290716AbSARPLK>; Fri, 18 Jan 2002 10:11:10 -0500
Received: from pl100.nas921.ichikawa.nttpc.ne.jp ([210.165.234.100]:34621 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S290715AbSARPK7>;
	Fri, 18 Jan 2002 10:10:59 -0500
Date: Sat, 19 Jan 2002 00:10:29 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wavelan_cs update (Pcmcia backport)
Message-Id: <20020119001029.42599989.bruce@ask.ne.jp>
In-Reply-To: <3C47ADAC.6D92E2A5@mandrakesoft.com>
In-Reply-To: <20020111151825.C15515@bougret.hpl.hp.com>
	<3C47ADAC.6D92E2A5@mandrakesoft.com>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002 00:07:56 -0500
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:

> Jean Tourrilhes wrote:
> 
> > @@ -1404,7 +1417,7 @@ wv_init_info(device *     dev)
> >           printk("2430.5");
> >           break;
> >         default:
> > -         printk("unknown");
> > +         printk("???");
> >         }
> >      }
> > 

> -       * (does it work for everybody XXX - especially old cards...) */
> +       * (does it work for everybody ??? - especially old cards...) */

> 
> you are reverting a change - "???" causes a trigraph-related warning in
> newer gcc

Just asking, but isn't it just a bit bogus for gcc to raise warnings about
things in comments?
