Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264193AbTEaHnN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 03:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbTEaHnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 03:43:13 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:36547 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264193AbTEaHnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 03:43:12 -0400
Date: Sat, 31 May 2003 09:56:15 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "David S. Miller" <davem@redhat.com>
Cc: jmorris@intercode.com.au, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
Message-ID: <20030531075615.GA25089@wohnheim.fh-wedel.de>
References: <20030530174319.GA16687@wohnheim.fh-wedel.de> <20030530.171410.104043496.davem@redhat.com> <20030531064851.GA20822@wohnheim.fh-wedel.de> <20030530.235505.23020750.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030530.235505.23020750.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC List pruned a little.

On Fri, 30 May 2003 23:55:05 -0700, David S. Miller wrote:
>    From: Jörn Engel <joern@wohnheim.fh-wedel.de>
>    
>    How about preemption?  zlib operations take their time, so at least on
>    up, it makes sense to preempt them, when not in softirq context.  Can
>    this still be done lockless?
> 
> You'll need to disable preemption.

My gut feeling claims that this would hurt interactivity.  Con, would
contest on a jffs2 (zlib compressed) filesystem be able to show
interactivity problems wrt zlib?

Jörn

-- 
Do not stop an army on its way home.
-- Sun Tzu
