Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUIWAnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUIWAnX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 20:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUIWAnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 20:43:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60604 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266183AbUIWAnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 20:43:21 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: 2.6.9-rc2-mm2
Date: Wed, 22 Sep 2004 20:43:01 -0400
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <16722.7004.928367.771460@wombat.chubb.wattle.id.au>
In-Reply-To: <16722.7004.928367.771460@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409222043.01098.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 22, 2004 8:39 pm, Peter Chubb wrote:
> >>>>> "Jesse" == Jesse Barnes <jbarnes@engr.sgi.com> writes:
>
> Jesse> On Wednesday, September 22, 2004 4:12 pm, Andrew Morton wrote:
> >> - This kernel doesn't work on ia64 (instant reboot).  But neither
> >> does 2.6.9-rc2, nor current Linus -bk.  Is it just me?
>
> Jesse> I certainly hope so.  Current bk works on my 2p Altix, and iirc
> Jesse> 2.6.9-rc2 worked as well.  I'm trying 2.6.9-rc2-mm2 right now.
> Jesse> I haven't tried generic_defconfig yet either, maybe that's it?
>
> It no longer works on ZX.  Don't know why.

Maybe this is another, more severe instance of the problem James reported last 
week that was worked around by enabling CONFIG_DISCONTIGMEM.

Jesse
