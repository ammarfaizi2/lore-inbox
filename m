Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266576AbTABW3U>; Thu, 2 Jan 2003 17:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbTABW3U>; Thu, 2 Jan 2003 17:29:20 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46985
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266576AbTABW3T>; Thu, 2 Jan 2003 17:29:19 -0500
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: Thomas Ogrisegg <tom@rhadamanthys.org>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030102222816.GF2461@work.bitmover.com>
References: <20021230010953.GA17731@window.dhis.org>
	<20021230012937.GC5156@work.bitmover.com>
	<1041489421.3703.6.camel@rth.ninka.net>
	<20030102221210.GA7704@window.dhis.org> 
	<20030102222816.GF2461@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Jan 2003 23:20:44 +0000
Message-Id: <1041549644.24829.66.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-02 at 22:28, Larry McVoy wrote:
> The VM cost hurts.  Badly.  Imagine that the network costs ZERO.  Then
> the map/unmap/vm ops become the dominating term.  That's why it is a
> fruitless approach, it still has a practical limit which is too low.

It depends how predictable your content is. With a 64bit box and a porn
server its probably quite tidy

