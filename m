Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbUDPPuI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbUDPPuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:50:08 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:63360
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S263291AbUDPPuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:50:04 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       shannon@widomaker.com, Phil Oester <kernel@linuxace.com>
In-Reply-To: <20040416144433.GE2253@logos.cnet>
References: <20040416011401.GD18329@widomaker.com>
	 <1082079061.7141.85.camel@lade.trondhjem.org>
	 <20040415185355.1674115b.akpm@osdl.org>
	 <1082084048.7141.142.camel@lade.trondhjem.org>
	 <20040416045924.GA4870@linuxace.com>
	 <1082093346.7141.159.camel@lade.trondhjem.org>
	 <20040416144433.GE2253@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082130599.2581.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Apr 2004 08:50:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-16 at 07:44, Marcelo Tosatti wrote:
> Maaybe TCP should be the default then ? In case no one finds the reason 
> why NFS over UDP is slower on 2.6.x than 2.4.x. It seems there are
> quite a few reports confirming the slowdown. Maybe Jamie Lokier is right in 
> theory?

Are you talking about the TCP server configuration option here, or the
TCP mount option? IMO both should be default.

I've got a patch for the "mount" program, which I've been intending to
send on to Andries (I've just been too busy for the past few weeks to
give it a last review).

Cheers,
  Trond
