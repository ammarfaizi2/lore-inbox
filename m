Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbSLPPZx>; Mon, 16 Dec 2002 10:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbSLPPZx>; Mon, 16 Dec 2002 10:25:53 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62429
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265880AbSLPPZx>; Mon, 16 Dec 2002 10:25:53 -0500
Subject: Re: Dual Xeon w/ HT: Kernel can't find second CPU
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Patrick R. McManus" <mcmanus@ducksong.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021216144243.GA9352@ducksong.com>
References: <233C89823A37714D95B1A891DE3BCE5202AB1AD5@xch-a.win.zambeel.com>
	<20021212162914.E28629@deltelco.com>  <20021216144243.GA9352@ducksong.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Dec 2002 16:13:20 +0000
Message-Id: <1040055200.13910.47.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-16 at 14:42, Patrick R. McManus wrote:
> I can't build a kernel for my dual xeon e7500 board, with
> hyperthreading enabled, that sees 4 logical processors. I can boot the
> redhat 8 kernel and that sees 4, but my build of  2.4.20-ac2 gets me
> 'warning sibling not found' messages and just 2 cpus. 

The -ac tree gets this wrong in some cases. Since Marcelo is merging
code that is newer and replaces the buggy bits I don't see any point in
fixing my -ac tree for this one as it is going to get dropped out anyway

