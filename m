Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267456AbTA3KiQ>; Thu, 30 Jan 2003 05:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267471AbTA3KiQ>; Thu, 30 Jan 2003 05:38:16 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30853
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267456AbTA3KiQ>; Thu, 30 Jan 2003 05:38:16 -0500
Subject: Re: [PATCH] Update PnP IDE (2/6)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Belay <ambx1@neo.rr.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
In-Reply-To: <20030129222632.GD2246@neo.rr.com>
References: <20030125201516.GA12794@neo.rr.com>
	 <Pine.LNX.4.10.10301251824510.1744-100000@master.linux-ide.org>
	 <20030129222632.GD2246@neo.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043926921.28133.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 30 Jan 2003 11:42:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-29 at 22:26, Adam Belay wrote:
> a mess when PnP hotplugging is finally used.  Also if a pnp protocol was presented
> in a removable module format, the protocol may want drivers to detach from its
> devices upon module unload.  Are there any other hotpluggable ide devices and if
> so how are they handled?

The IDE layer does not currently handle hotplugging. It needs a lot of work
before that can happen

