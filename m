Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVEBUvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVEBUvh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 16:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVEBUvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 16:51:37 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:36100 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261766AbVEBUvf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 16:51:35 -0400
Date: Mon, 2 May 2005 16:30:36 -0400
From: Jeff Dike <jdike@addtoit.com>
To: blaisorblade@yahoo.it
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/1] uml: remove jail mode + other leftovers
Message-ID: <20050502203036.GA13721@ccure.user-mode-linux.org>
References: <20050501163818.142A3400F1@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050501163818.142A3400F1@zion>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2005 at 06:38:15PM +0200, blaisorblade@yahoo.it wrote:
> 
> This var is currently useless, as it's apparent from reading the code. Until
> 2.6.11 it was used in some code related to jail mode, in the same proc.:
> 
>         if(jail){
> 		while(!reading) sched_yield();
> 	}
> 
> jail mode has been dropped, together with that use, so let's finish dropping
> this.
> 
> Also, remove some other useless definitions I met.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Acked-by: Jeff Dike <jdike@addtoit.com>
