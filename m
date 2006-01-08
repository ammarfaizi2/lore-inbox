Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWAHLQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWAHLQo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 06:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWAHLQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 06:16:44 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:41228 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964869AbWAHLQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 06:16:44 -0500
Date: Sun, 8 Jan 2006 12:16:38 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Bernd Eckenfels <be-mail2006@lina.inka.de>
Cc: linux-kernel@vger.kernel.org, gcoady@gmail.com
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Message-ID: <20060108111638.GA15093@w.ods.org>
References: <20060108095741.GH7142@w.ods.org> <E1EvXi5-0000kv-00@calista.inka.de> <20060108105401.GI7142@w.ods.org> <20060108110919.GA6865@lina.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060108110919.GA6865@lina.inka.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 12:09:19PM +0100, Bernd Eckenfels wrote:
> On Sun, Jan 08, 2006 at 11:54:01AM +0100, Willy Tarreau wrote:
> > > it eats it in high interrupt load.
> > *high* ? he never goes far beyond 1000/s !
> 
> it is 10 times higher on 2.6 than 2.4 (I dont think this can be explained
> by the timer, only.)
> 
> > quite possibly, but I'd rather think it's more precisely related
> > to the ping-pong in the scheduler between grep, cut and ssh.
> 
> Could be, that would also send smaller buffers to tcp...

that's true, and that could explain the higher interrupt rate.

> Gruss
> Bernd

Cheers,
Willy

