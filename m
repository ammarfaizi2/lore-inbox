Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbULIPYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbULIPYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 10:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbULIPYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 10:24:39 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:61130 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261521AbULIPYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 10:24:09 -0500
Date: Fri, 10 Dec 2004 02:23:54 +1100
From: Greg Banks <gnb@sgi.com>
To: Akinobu Mita <amgta@yacht.ocn.ne.jp>
Cc: Greg Banks <gnb@sgi.com>, John Levon <levon@movementarian.org>,
       Philippe Elie <phil.el@wanadoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: [mm patch] oprofile: backtrace operation does not initialized
Message-ID: <20041209152354.GD6987@sgi.com>
References: <200412081830.51607.amgta@yacht.ocn.ne.jp> <20041209014622.GB48804@compsoc.man.ac.uk> <20041209015024.GG4239@sgi.com> <200412092322.27096.amgta@yacht.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412092322.27096.amgta@yacht.ocn.ne.jp>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 11:22:27PM +0900, Akinobu Mita wrote:
> On Thursday 09 December 2004 10:50, Greg Banks wrote:
> > Ok, how about this patch?
> [...]
> Since the timer interrupt is the only way of getting sampling for oprofile
> on such environments. if no module parameters specified (i.e. timer == 0),
> then oprofile_timer_init() is never called. and I have got this error:

Bother, back to the drawing board.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
