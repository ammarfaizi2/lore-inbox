Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265292AbUFTIDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265292AbUFTIDH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 04:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265308AbUFTIDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 04:03:06 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:5899 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265292AbUFTIDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 04:03:04 -0400
Date: Sun, 20 Jun 2004 09:56:50 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, frankvm@xs4all.nl, sdake@mvista.com,
       liste@jordet.nu, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: [2.4] page->buffers vanished in journal_try_to_free_buffers()
Message-ID: <20040620075650.GH29808@alpha.home.local>
References: <1075832813.5421.53.camel@chevrolet.hybel> <Pine.LNX.4.58L.0402052139420.16422@logos.cnet> <1078225389.931.3.camel@buick.jordet> <1087232825.28043.4.camel@persist.az.mvista.com> <20040615131650.GA13697@logos.cnet> <1087322198.8117.10.camel@persist.az.mvista.com> <20040617131600.GB3029@logos.cnet> <20040617200859.7fada9fe.akpm@osdl.org> <20040619194849.GA2843@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040619194849.GA2843@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Sat, Jun 19, 2004 at 04:48:49PM -0300, Marcelo Tosatti wrote:
 
> +		if (!unlikely(tmp)) {

I think you meant "if (unlikely(!tmp))" here. Howver this does not make
a big difference.

Regards,
willy

