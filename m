Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbTCCQem>; Mon, 3 Mar 2003 11:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266839AbTCCQem>; Mon, 3 Mar 2003 11:34:42 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57243
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266771AbTCCQel>; Mon, 3 Mar 2003 11:34:41 -0500
Subject: RE: [PATCH] cciss: add passthrough ioctl
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <45B36A38D959B44CB032DA427A6E10640451336D@cceexc18.americas.cpqcorp.net>
References: <45B36A38D959B44CB032DA427A6E10640451336D@cceexc18.americas.cpqcorp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046713702.6530.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 17:48:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 16:17, Cameron, Steve wrote:
> 
> > On Mon, Mar 03, 2003 at 09:26:40AM +0600, Stephen Cameron wrote:
> > > Because, in order to flash the array controller firmware,
> > > it's got to be done that way...
> > 
> > I don't buy this. Sorry. What's against creating a device for this
> > controller itself ? 
> > (And yes, the kernel could use a formal ioctl number for "upgrade firmware") 
> 
> Arg.  Now I wish I didn't already port that code to 10 distributions.
> Please shoot me.
> 
> How do you want it done?

I really think it should stay as it is for now. Maybe in 2.7 we need to have
the firmware update argument, but we need to have it about *all* related
drivers and do it once and right.

