Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbUAUUlF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 15:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUAUUlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 15:41:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:31654 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264145AbUAUUlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 15:41:01 -0500
X-Authenticated: #20450766
Date: Wed, 21 Jan 2004 21:37:02 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
In-Reply-To: <Pine.LNX.4.58.0401192259330.2123@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0401212117020.5441-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004, Linus Torvalds wrote:

> On Mon, 19 Jan 2004, Justin T. Gibbs wrote:
> >
> > Does the maintainer have the ability to veto changes that harm the
> > code they maintain?
>
> Nope. Nobody has that right.
>
> Even _I_ don't veto changes that the right people push (my motto:
> "everybody is wrong sometimes: when enough people complain, even I am
> wrong").
>
> In particular, maintainers of "conceptually higher" generally always have
> priority. If Al Viro says a filesystem is doing something wrong from a VFS
> standpoint, then that filesystem is broken - regardless of whether the
> filesystem maintainer agrees or not. Because the VFS layer requirements
> trump any low-level filesystem issues.

Linus

May I try to sweeten the pill a bit? I think, I am not contradicting what
you said, but just complementing it, thinking, that the direct code
maintainer has a right and priority in modifying the code, even over the
"conceptionally higher" level. Say, if some code is found to be broken,
the problem and possible fixes should first be reported to the direct
maintainer. And only if the maintainer is not co-operating suitably (e.g.,
in the opinion of those "higher" ones), only then necessary modifications
can be made directly. In other words, a situation, when, say, a subsystem
maintainer silently modifies some driver-code, without even letting the
direct maintainer know, is undesirable. A better solution would be to
inform the driver maintainer of the problem / send a patch. And only if no
suitable action follows, force the necessary modifications.

That was just a mere speculation, not pertaining to any specific case.

Thanks
Guennadi
---
Guennadi Liakhovetski




