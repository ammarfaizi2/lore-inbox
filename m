Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268473AbTCFWyj>; Thu, 6 Mar 2003 17:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268485AbTCFWyj>; Thu, 6 Mar 2003 17:54:39 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36008
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268473AbTCFWyi>; Thu, 6 Mar 2003 17:54:38 -0500
Subject: Re: Linux 2.5.64-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Steven Cole <elenstev@mesatop.com>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, aeb@cwi.nl
In-Reply-To: <20030306225823.GA2764@win.tue.nl>
References: <200303061915.h26JFAP06033@devserv.devel.redhat.com>
	 <1046985881.4992.99.camel@spc9.esa.lanl.gov>
	 <1046991076.17715.129.camel@irongate.swansea.linux.org.uk>
	 <20030306225823.GA2764@win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046995826.18158.138.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 07 Mar 2003 00:10:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 22:58, Andries Brouwer wrote:
> On Thu, Mar 06, 2003 at 10:51:16PM +0000, Alan Cox wrote:
> > On Thu, 2003-03-06 at 21:24, Steven Cole wrote:
> > > I backed out the same partitions stuff as before, and 2.5.64-ac1 boots
> > > fine.  This is the resulting diff.
> > 
> > Backing it out isnt an option in the end, it has to get fixed 8(
> 
> Usually I try to follow partition and geometry stuff, but this
> is a discussion I missed.  What is wrong?

I've got a bug somewhere in the ide_xlate stuff I restored because some
people do need it. The bug is in my code not in the partition stuff
though.

