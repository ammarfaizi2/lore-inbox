Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263548AbUDPPZV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263480AbUDPPZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:25:20 -0400
Received: from mail.cyclades.com ([64.186.161.6]:64993 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263548AbUDPPRF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:17:05 -0400
Date: Fri, 16 Apr 2004 11:46:01 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       shannon@widomaker.com, Phil Oester <kernel@linuxace.com>
Subject: Re: NFS and kernel 2.6.x
Message-ID: <20040416144601.GF2253@logos.cnet>
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <1082084048.7141.142.camel@lade.trondhjem.org> <20040416045924.GA4870@linuxace.com> <1082093346.7141.159.camel@lade.trondhjem.org> <20040416144433.GE2253@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040416144433.GE2253@logos.cnet>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 11:44:33AM -0300, Marcelo Tosatti wrote:
> On Thu, Apr 15, 2004 at 10:29:06PM -0700, Trond Myklebust wrote:
> > På to , 15/04/2004 klokka 21:59, skreiv Phil Oester:
> > 
> > > If simply upgrading from 2.4.x to 2.6.x is going to make UDP mounts unusable,
> > > perhaps this should be documented -- or the option should be deprecated.
> > 
> > Put simply: I am not interested in wasting _my_ time investigating cases
> > where UDP is performing badly if TCP is working fine. The variable
> > reliability issues with UDP are precisely why we worked to get the TCP
> > stuff working efficiently.
> > 
> > As for blanket statements like the above: I have seen no evidence yet
> > that they are any more warranted in 2.6.x than they were in 2.4.x. At
> > least not as long as I continue to see wire speed performance on reads
> > and writes on UDP on all my own test setups.
> 
> Maaybe TCP should be the default then ? 

Or just make a big warning in the Kconfig. Distros will
set it to the default...

> In case no one finds the reason 
> why NFS over UDP is slower on 2.6.x than 2.4.x. It seems there are
> quite a few reports confirming the slowdown. Maybe Jamie Lokier is right in 
> theory?

