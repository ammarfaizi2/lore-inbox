Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbSJRQIi>; Fri, 18 Oct 2002 12:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSJRQIh>; Fri, 18 Oct 2002 12:08:37 -0400
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:18736 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S265205AbSJRQIO>; Fri, 18 Oct 2002 12:08:14 -0400
Date: Fri, 18 Oct 2002 17:13:56 +0100
To: christophe varoqui <christophe.varoqui@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: block allocators and LVMs
Message-ID: <20021018161356.GA3438@fib011235813.fsnet.co.uk>
References: <3DA24B4A0064C333@mel-rta8.wanadoo.fr> <1034946264.3db006d87c82c@imp.free.fr> <20021018150337.GA3195@fib011235813.fsnet.co.uk> <200210181751.47361.christophe.varoqui@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210181751.47361.christophe.varoqui@free.fr>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 05:51:47PM +0200, christophe varoqui wrote:
> I realize the whole concept is different, but could extent remapping alleviate 
> the need of an *intelligent* FS block allocator, as it ensure the best 
> statistical-average IO perfs.

Yes, you would probably find an intelligent fs allocator and an
automatically remapping lvm would fight each other.  You'd have to
choose one or the other.

- Joe
