Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269216AbUICB2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269216AbUICB2g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269530AbUICB2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:28:35 -0400
Received: from [195.23.16.24] ([195.23.16.24]:56291 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S269216AbUICB1J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:27:09 -0400
Message-ID: <1094175114.4137c98a2b4ae@webmail.grupopie.com>
Date: Fri,  3 Sep 2004 02:31:54 +0100
From: "" <pmarques@grupopie.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] kallsyms: speed up /proc/kallsyms
References: <4134DEF4.8090001@grupopie.com> <1094016277.17828.53.camel@bach> <4135AFBE.1000707@grupopie.com> <20040901192755.GC7219@mars.ravnborg.org> <41362694.9070101@grupopie.com> <20040901195132.GA15432@mars.ravnborg.org> <41370C7E.4020304@grupopie.com> <20040902221733.GA8868@mars.ravnborg.org>
In-Reply-To: <20040902221733.GA8868@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.89.223
Content-Transfer-Encoding: 7BIT
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.44; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Ravnborg <sam@ravnborg.org>:

> On Thu, Sep 02, 2004 at 01:05:18PM +0100, Paulo Marques wrote:
>  
> > All 3 patches will be against 2.6.9-rc1-mm2. I'm just saying
> > this to make sure I understood correctly what I'm supposed to
> > do.
> 
> Preferable on top of Linus - latest.

I was preparing to do just that, but bumped into a simple problem.

If I patch against Linus tree, then the 3 patches suggested by
Rusty Russell make no sense, because the Linus tree still has stem
compression. So there is no inconsistency bug and there are no
comments to add, there is only a single patch to go from stem
compression to the new compression scheme.

It does not sound so bad to have just one patch that appears at 
2.6.9-rc2 that says "change kallsyms compression scheme", so I 
have no problem producing this patch.

I'm now holding on to avoid start sending patches against
different trees and make a total mess :(


