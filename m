Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTLPQnt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 11:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTLPQnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 11:43:49 -0500
Received: from piro.phys.uniroma1.it ([141.108.1.98]:57228 "EHLO piro")
	by vger.kernel.org with ESMTP id S261885AbTLPQnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 11:43:45 -0500
Subject: Re: another oops, maybe I'll downgrade to 2.4.22.. :(
From: Cristiano De Michele <demichel@na.infn.it>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, torvalds@transmeta.com
In-Reply-To: <Pine.LNX.4.44.0312161426510.7409-100000@logos.cnet>
References: <Pine.LNX.4.44.0312161426510.7409-100000@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Department of Physics, University of Naples "Federico II"
Message-Id: <1071593009.963.2.camel@piro>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Dec 2003 17:43:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-16 at 17:27, Marcelo Tosatti wrote:
> On Sun, 14 Dec 2003, Cristiano De Michele wrote:
> 
> > Hi, 
> > another oops got using kernel 2.4.23 caused to gkrellm
> > I'm on debian unstable up to date 
> > 
> > c012c2ae
> > *pde = 00000000
> > Oops: 0002
> > CPU:    0
> > EIP:    0010:[<c012c2ae>]    Tainted: P 
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00210282
> > eax: 5a7fbd58   ebx: c6b0bf90   ecx: c158e0c0   edx: d67fbd7c
> > esi: 00001000   edi: dc7f1614   ebp: cf9b7c3c   esp: cf9b7c1c
> > ds: 0018   es: 0018   ss: 0018
> > Process gkrellm (pid: 18516, stackpage=cf9b7000)
> > Stack: c6b0bf90 c6b0b9ec 00009000 408c3000 c6b0b6f4 dc7f1614 cf9b6000 dc7f1614 
> >        cf9b7c50 c011a0a8 dc7f1614 00000080 de8af0c4 cf9b7c74 c0143883 dc7f1614 
> >        cf9b7ed0 00000000 dc7f1614 00000000 cf9b6000 dd1bb580 cf9b7c98 c014394b 
> > Call Trace:    [<c011a0a8>] [<c0143883>] [<c014394b>] [<c0158872>] [<c016650a>]
> >   [<c016cde3>] [<c0135672>] [<c0158560>] [<c0143f97>] [<c014339b>] [<c0144162>]
> >   [<c01079bf>] [<c010900f>]
> > Code: 89 10 89 1c 24 e8 b8 ec ff ff 8b 45 ec 89 74 24 08 89 3c 24
> > 
> > 
> > >>EIP; c012c2ae <exit_mmap+9e/140>   <=====
> 
> Does the problem happen without the binary-only modules? It seems you are using the nvidia module.
I thought that latest releases of nvidia module are built from
sources...
anyway I'll try to use the x11 nv driver (without nvidia module) and
see,
I'll let you know soon
bye Cristiano

-- 
Cristiano De Michele <demichel@na.infn.it>
Department of Physics, University of Naples "Federico II"
