Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbTDOVRv (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbTDOVRv 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:17:51 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50624
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264082AbTDOVRt convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 17:17:49 -0400
Subject: Re: DMA transfers in 2.5.67
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1x3ckjfs2v.fsf@zaphod.guide>
References: <yw1x3ckjfs2v.fsf@zaphod.guide>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1050438684.28586.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Apr 2003 21:31:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-15 at 21:01, Måns Rullgård wrote:
> What do I need to do in a driver before doing DMA transfers to a PCI
> card?  Using a driver that worked in 2.4 gives a throughput of only 10
> MB/s in 2.5.67.  Is there some magic initialization that I have
> missed?

Assuming your driver uses the new PCI api for DMA in 2.4/2.5 then there
isnt really anything to watch. Is this on a box with > 800Mb of memory
however ?

