Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267355AbSLRVuR>; Wed, 18 Dec 2002 16:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267356AbSLRVuR>; Wed, 18 Dec 2002 16:50:17 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36329
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267355AbSLRVuR>; Wed, 18 Dec 2002 16:50:17 -0500
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133 
	Promise ctrlr, or...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "D.A.M. Revok" <marvin@synapse.net>
Cc: Andre Hedrick <andre@linux-ide.org>, Manish Lachwani <manish@Zambeel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212181635.58164.marvin@synapse.net>
References: <Pine.LNX.4.10.10212180241580.8350-100000@master.linux-ide.org>
	 <200212181635.58164.marvin@synapse.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Dec 2002 22:38:42 +0000
Message-Id: <1040251122.26501.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 21:35, D.A.M. Revok wrote:
> So.  I /think/ that somehow the Promise controller isn't being 
> initialized properly by the Linux kernel, UNLESS the mobo's BIOS inits 
> it first?

In some situations yes. The BIOS does stuff including fixups we mere
mortals arent permitted to know about.

