Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267476AbUIATxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267476AbUIATxt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUIATuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:50:24 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:19737 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267483AbUIATt3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:49:29 -0400
Date: Wed, 1 Sep 2004 21:51:32 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] kallsyms: speed up /proc/kallsyms
Message-ID: <20040901195132.GA15432@mars.ravnborg.org>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
References: <4134DEF4.8090001@grupopie.com> <1094016277.17828.53.camel@bach> <4135AFBE.1000707@grupopie.com> <20040901192755.GC7219@mars.ravnborg.org> <41362694.9070101@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41362694.9070101@grupopie.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 08:44:20PM +0100, Paulo Marques wrote:
> Sam Ravnborg wrote:
> >...
> >
> >When you have made the split Rusty requested and implemented
> >the above could you please send patches to me. I will add them to
> >my kbuild queue.
> 
> I'd be glad to do this, but AFAICT the patch already entered the mm
> tree, so I think that splitting it now, or sending it through a
> different path would probably add to the confusion I already
> managed to create :(

I prefer the split-up Rusty requested.
It will then enter -mm via my queue - but as three logical separated
patches. This is much better when looking into this later.

Andrew will just back-out your previous patch and mark it as 'merged'.

	Sam
