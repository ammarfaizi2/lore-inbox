Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVBAH54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVBAH54 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 02:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVBAH4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 02:56:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:31651 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261858AbVBAHz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 02:55:58 -0500
Date: Mon, 31 Jan 2005 23:54:13 -0800
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/block/aoe/aoechr.c cleanups
Message-ID: <20050201075413.GF21608@kroah.com>
References: <20050129133520.GV28047@stusta.de> <87acqpu0od.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87acqpu0od.fsf@coraid.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 09:34:58AM -0500, Ed L Cashin wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> 
> > This patch contains the following cleanups:
> > - make the needlessly global struct aoe_fops static
> > - #if 0 the unused global function aoechr_hdump
> 
> Thanks for the patch.  The original patch leaves the prototype for
> aoechr_hdump in aoe.h, but since this function is just for debugging,
> it seems better to just take both prototype and definition out.
> 
> 
> remove aoechr_hdump
> make aoe_fops static
> 
> Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

Applied, thanks.

greg k-h

