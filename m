Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbTBSVNv>; Wed, 19 Feb 2003 16:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbTBSVNv>; Wed, 19 Feb 2003 16:13:51 -0500
Received: from rth.ninka.net ([216.101.162.244]:7073 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261733AbTBSVN3>;
	Wed, 19 Feb 2003 16:13:29 -0500
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
From: "David S. Miller" <davem@redhat.com>
To: Ion Badulescu <ionut@badula.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0302191316230.29393-100000@guppy.limebrokerage.com>
References: <Pine.LNX.4.44.0302191316230.29393-100000@guppy.limebrokerage.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Feb 2003 14:07:56 -0800
Message-Id: <1045692476.14306.14.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-19 at 10:20, Ion Badulescu wrote:
> Well, yes and no. Indeed those checks are optimized away, but as a result 
> of using them most data-access macros must be converted to inline 
> functions. And, last I heard at least, gcc was optimizing inline functions 
> much worse than preprocessor macros.

Not true, you can still use macros and GCC is saner with inlines
these days.

Your arguments are nice to encourage your patch to be accepted,
they are however not correct.

