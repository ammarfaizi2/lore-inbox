Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274939AbTHFI6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 04:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274942AbTHFI6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 04:58:21 -0400
Received: from angband.namesys.com ([212.16.7.85]:29354 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S274939AbTHFI6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 04:58:20 -0400
Date: Wed, 6 Aug 2003 12:58:19 +0400
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030806085819.GC14457@namesys.com>
References: <20030802142734.5df93471.skraw@ithnet.com> <Pine.LNX.4.44.0308051340010.2848-100000@logos.cnet> <20030806094150.4d7b0610.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806094150.4d7b0610.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Aug 06, 2003 at 09:41:50AM +0200, Stephan von Krawczynski wrote:

> > Is this _STOCK_ 2.4.22-pre10 (no vmware, no other modules) ? 
> Hello Marcelo,
> today I have a fresh -pre10 oops for you.
> Everything seems to start with (there is no i/o error or the like, is it
> possible that the fs got damaged during former crashes?):

Well, you'd better run reiserfsck after crashes with binary modules just to make sure everything is ok.

> sd(8,17):vs-4080: reiserfs_free_block: free_block (0811:14478481)[dev:blocknr]:
> bit already cleared
> sd(8,17):vs-4080: reiserfs_free_block: free_block (0811:14478445)[dev:blocknr]:
> bit already cleared
> sd(8,17):vs-4080: reiserfs_free_block: free_block (0811:14478441)[dev:blocknr]:
> bit already cleared
> sd(8,17):vs-4080: reiserfs_free_block: free_block (0811:14478348)[dev:blocknr]:
> bit already cleared

Bye,
    Oleg
