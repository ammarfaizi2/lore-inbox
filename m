Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263018AbSJBJk5>; Wed, 2 Oct 2002 05:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263021AbSJBJk5>; Wed, 2 Oct 2002 05:40:57 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:41220 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S263018AbSJBJk4>;
	Wed, 2 Oct 2002 05:40:56 -0400
Date: Wed, 2 Oct 2002 11:46:12 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Padraig Brady <padraig.brady@corvil.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       Miroslav Rudisin <miero@atrey.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] default file permission for vfat
Message-ID: <20021002094612.GA2587@alpha.home.local>
References: <20021001173908.GA15838@atrey.karlin.mff.cuni.cz> <20021001185526.GA704@alpha.home.local> <3D9AB638.60209@corvil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9AB638.60209@corvil.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 10:02:48AM +0100, Padraig Brady wrote:
> Willy Tarreau wrote:
> >On Tue, Oct 01, 2002 at 07:39:08PM +0200, Miroslav Rudisin wrote:
> >
> >>Hi,
> >>
> >>The attached patch change default permission of files on [v]fatfs.
> >>Default RWX have no utilization. This patch remove exec flag.
> >
> >Hi !
> >
> >This is sometimes very useful to put init scripts on a floppy disk.
> 
> Not the common case and you can use different format floppies for this 
> anyway.

not when you want your customers to be able to edit their firewall config
with their M$ PC !

Willy
