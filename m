Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbUAGNhe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 08:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbUAGNhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 08:37:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:31147 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265530AbUAGNhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 08:37:31 -0500
X-Authenticated: #20450766
Date: Wed, 7 Jan 2004 14:36:34 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
In-Reply-To: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange>
Message-ID: <Pine.LNX.4.44.0401071431520.479-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jan 2004, Guennadi Liakhovetski wrote:

> server with 2.6.0 kernel:
>
> fast:2.6.0-test11	2m21s (*)
> fast:2.4.20		16.5s
> SA1100:2.4		never finishes (*)
> PXA:2.4.21-rmk1-pxa1	as above
> PXA:2.6.0-rmk1-pxa	as above
>
> server: 2.4.21
>
> fast:2.6.0-test11	6s
> fast:2.4.20		5s
> SA1100:2.4.19-rmk7	3.22s
> PXA:2.4.21-rmk1-pxa1	7s
> PXA:2.6.0-rmk2-pxa	1) 50s (**)
> (***)			2) 27s (**)

s/fast/PC2/

Further, I tried the old 3c59x card - same problems persist. Also tried
PC2 as the server - same. nfs-utils version 1.0.6 (Debian Sarge). I sent a
copy of the yesterday's email + new details to nfs@lists.sourceforge.net,
netdev@oss.sgi.com, linux-net@vger.kernel.org.

Strange, that nobody is seeing this problem, but it looks pretty bad here.
Unless I missed some necessary update somewhere? The only one that seemed
relevant - nfs-utils on the server(s) from Documentation/Changes I
checked.

Thanks
Guennadi
---
Guennadi Liakhovetski



