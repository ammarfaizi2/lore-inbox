Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVFVT1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVFVT1k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 15:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVFVT1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 15:27:39 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:42456 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261657AbVFVT0l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 15:26:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MXXivs+wvpexnF+Ff+7mgy+yXrFIhYhkPUJwFQ9k3K3g2qTYq/Ipa3ft2p84BjEO2oobuAaSOTD/YGEisD1OgNaNKpfuOisnROT7roPaL/qleA+vljLcvX7z6UwSLVM3sN6hJYjqKcpLL8sSkKRhniCQV/tTzGFobwEQvlbhSss=
Message-ID: <9a87484905062212264e82d770@mail.gmail.com>
Date: Wed, 22 Jun 2005 21:26:37 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: Problem compiling 2.6.12
Cc: George Kasica <georgek@netwrx1.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050622164436.GI3705@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0506221026130.4837@eagle.netwrx1.com>
	 <9a874849050622085975b67c06@mail.gmail.com>
	 <20050622164436.GI3705@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/05, Adrian Bunk <bunk@stusta.de> wrote:
> On Wed, Jun 22, 2005 at 05:59:45PM +0200, Jesper Juhl wrote:
> >
> > Don't use a 2.4.x config as the basis for a 2.6.x kernel .
> > Build your first 2.6.x kernel config using "make menuconfig", "make
> > config", make xconfig" or similar, /then/ you can use that config in
> > the future as a base for other 2.6.x kernels with "make oldconfig".
> 
> First of all, this shouldn't result in problems like the one he
> reported (see my other mail).
> 
> And I'm surprised you are saying this. I'd have expected that running
> "make oldconfig" with a 2.4 kernel should give him a working
> configuration.
> 
> Can you explain where you'd expect problems so that we can fix them?
> 
It's been ages since I personally moved to 2.6, but around the time
when I made the switch I fed several 2.4 configs to oldconfig and the
resulting 2.6 kernels either didn't build properly or they build but
were broken in strange ways. Redoing the 2.6 configs from scratch
always fixed the problems back then. I also encountered similar
reports from people on IRC. Things may have improved since then, but
then again maybe they have not.. I'll see if I can dig out a few of my
old 2.4 configs and retest if there are still issues.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
