Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbUDYEKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUDYEKN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 00:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbUDYEKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 00:10:13 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:9925 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262902AbUDYEKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 00:10:04 -0400
Message-Id: <200404250305.i3P355eF003826@pincoya.inf.utfsm.cl>
To: Willy Tarreau <willy@w.ods.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File system compression, not at the block layer 
In-Reply-To: Your message of "Sat, 24 Apr 2004 09:36:22 +0200."
             <20040424073622.GN596@alpha.home.local> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Sat, 24 Apr 2004 23:05:05 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> said:
> On Fri, Apr 23, 2004 at 10:24:58PM -0400, Tom Vier wrote:
> > On Fri, Apr 23, 2004 at 05:18:44PM -0400, Timothy Miller wrote:
> > > In a drive with multiple platters and therefore multiple heads, you 
> > > could read/write from all heads simultaneously.  Or is that how they 
> > > already do it?
> > 
> > fwih, there was once a drive that did this. the problem is track alignment.
> > these days, you'd need seperate motors for each head.

> I think they now all do it.

No.

>                             Haven't you noticed that drives with many
> platters are always faster than their cousins with fewer platters ? And
> I don't speak about access time, but about sequential reads.

Have you ever wondered how they squeeze 16 or more platters into that slim
enclosure? If you take them apart, the question evaporates: There are 2 or
3 platters in them, no more. The "many platters" are an artifact of BIOS'
"disk geometry" description.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
