Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316477AbSGRHDq>; Thu, 18 Jul 2002 03:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSGRHDq>; Thu, 18 Jul 2002 03:03:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38149 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316477AbSGRHDp>; Thu, 18 Jul 2002 03:03:45 -0400
Message-ID: <3D3666A9.7050608@zytor.com>
Date: Wed, 17 Jul 2002 23:56:41 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: "David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, viro@math.psu.edu,
       trond.myklebust@fys.uio.no, mnalis-umsdos@voyager.hr, aia21@cantab.net,
       al@alarsen.net, asun@cobaltnet.com, bfennema@falcon.csc.calpoly.edu,
       dave@trylinux.com, braam@clusterfs.com, chaffee@cs.berkeley.edu,
       dwmw2@infradead.org, eric@andante.org, hch@infradead.org,
       jaharkes@cs.cmu.edu, jakub@redhat.com, jffs-dev@axis.com,
       mikulas@artax.karlin.mff.cuni.cz, quinlan@transmeta.com,
       reiserfs-dev@namesys.com, mason@suse.com, rgooch@atnf.csiro.au,
       rmk@arm.linux.org.uk, shaggy@austin.ibm.com, tigran@veritas.com,
       urban@teststation.com, vandrove@vc.cvut.cz, vl@kki.org,
       zippel@linux-m68k.org, ahaas@neosoft.com
Subject: Re: Remain Calm: Designated initializer patches for 2.5
References: <20020718032331.5A36644A8@lists.samba.org> <3D366103.8010403@zytor.com> <20020717.232832.44968023.davem@redhat.com> <20020718065355.GA2248@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:
> 
> Well, I also like the non C99 variant that is in gcc as well, but if gcc is
> going to drop that in the future in favour of the C99 standard... But yes,
> not having the spacing is _ugly_, what I'm doing is:
> 
> static struct proto_ops SOCKOPS_WRAPPED(atalk_dgram_ops) = {
>         .family         = PF_APPLETALK,
>         .release        = atalk_release,
>         .bind           = atalk_bind,
>         .connect        = atalk_connect,
>         .socketpair     = sock_no_socketpair,
>         .accept         = sock_no_accept,

Agreed, that's the way to do it.

	-hpa


