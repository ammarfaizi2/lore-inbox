Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbTHYVTx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 17:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbTHYVTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 17:19:53 -0400
Received: from aneto.able.es ([212.97.163.22]:62083 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262168AbTHYVTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 17:19:51 -0400
Date: Mon, 25 Aug 2003 23:19:50 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] sizeof C types ...
Message-ID: <20030825211950.GC3346@werewolf.able.es>
References: <20030825191339.GA28525@www.13thfloor.at> <20030825202721.A10828@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030825202721.A10828@infradead.org>; from hch@infradead.org on Mon, Aug 25, 2003 at 21:27:21 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.25, Christoph Hellwig wrote:
> > char,
> 
> 8 bits
> 
> > short,
> 
> 16 bits
> 
> > int,
> 
> 32 bits
> 
> > long,
> 
> either 32 or 64 bits
> 
> > long int,
> 
> dito. long is just the short form of long int
> 
> > long long, ...
> 
> 64 bits
> 

If you don't go away from linux, OK.

Really:
char = 8bit
long int = 32 or 64, depending on arch
long long = 64 bits

int = ??? almost anything, depending on arch and compiler.
Run DOS on your P4, with an old compiler, and int defaults to 16 bits.
I think the same also happens for Win16.

int is defined ad the native word size of the hardware+OS.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-rc3-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
