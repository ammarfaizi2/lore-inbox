Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272972AbTHEXea (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 19:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272974AbTHEXea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 19:34:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:11403 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272972AbTHEXe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 19:34:29 -0400
Date: Tue, 5 Aug 2003 16:36:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: martin.konold@erfrakon.de, linux-kernel@vger.kernel.org
Subject: Re: Interactive Usage of 2.6.0.test1 worse than 2.4.21
Message-Id: <20030805163601.54b50689.akpm@osdl.org>
In-Reply-To: <16176.13066.601441.179810@wombat.chubb.wattle.id.au>
References: <200308050704.22684.martin.konold@erfrakon.de>
	<20030804232654.295c9255.akpm@osdl.org>
	<16176.13066.601441.179810@wombat.chubb.wattle.id.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb <peter@chubb.wattle.id.au> wrote:
>
> >> when using 2.6.0.test1 on a high end laptop (P-IV 2.2 GHz, 1GB RAM)
>  >> I notice very significant slowdown in interactive usage compared to
>  >> 2.4.21.
>  >> 
>  >> The difference is most easily seen when switching folders in
>  >> kmail. While 2.4.21 is instantaneous 2.6.0.test1 shows the clock
>  >> for about 2-3 seconds.
>  >> 
> 
>  I see the same problem, and I'm using XFS.  Booting with
>  elevator=deadline fixed it for me.  The anticipatory scheduler hurts
>  if you have a disc optimised for low power consumption, not speed.

Do you have a specific set of steps with which to reproduce this?
