Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUBRHSI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 02:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbUBRHSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 02:18:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5035 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262580AbUBRHSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 02:18:06 -0500
Date: Wed, 18 Feb 2004 08:17:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Paul Clements <Paul.Clements@SteelEye.com>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nbd oops on unload.
Message-ID: <20040218071752.GB27190@suse.de>
References: <20040217224700.GE6242@redhat.com> <4032FF7D.55D9935B@SteelEye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4032FF7D.55D9935B@SteelEye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18 2004, Paul Clements wrote:
> Dave Jones wrote:
> > 
> > modprobe nbd ; rmmod nbd  was enough to reproduce this one..
> > (2.6.3rc4)
> 
> hmmm...I'll look into it...out of curiosity, are you using any "unusual"
> kernel config options? I've done the same test myself many times and
> have not seen any problems...

It looks like 'the usual' 'several devices sharing a queue' oops on
unload.

-- 
Jens Axboe

