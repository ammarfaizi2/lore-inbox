Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264158AbTDJUce (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 16:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264161AbTDJUce (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 16:32:34 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4259
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264158AbTDJUb1 (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 16:31:27 -0400
Subject: Re: ATAPI cdrecord issue 2.5.67
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <b74i32$58g$1@cesium.transmeta.com>
References: <1049983308.888.5.camel@gregs> <1049984188.887.11.camel@gregs>
	 <1049986391.599.6.camel@teapot.felipe-alfaro.com>
	 <20030410193420.GD429@vitelus.com>  <b74i32$58g$1@cesium.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050003892.12498.45.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Apr 2003 20:44:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 20:53, H. Peter Anvin wrote:
> I think ide-scsi needs to be supported for some time going forward.
> After all, cdrecord, cdrdao, dvdrecord aren't going to be the only
> applications.

And far longer than that. People seem to be testing and demoing 
crazy things like SATA attached scanners, printers and even enclosure
services.

ide_scsi for 2.5 is about item 5000 on my list of things I care about.
The core reset code is now close to right (one race I don't understand)
so it should be possible to fix the 2.5 ide-scsi code (maybe by porting
the perfectly workable 2.4 code again 8))

Alan (IDE _coordinator_) 8)



