Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbTDKKe6 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 06:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbTDKKe5 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 06:34:57 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:47075 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264328AbTDKKe5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 06:34:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16022.40189.672337.427776@gargle.gargle.HOWL>
Date: Fri, 11 Apr 2003 12:46:21 +0200
From: mikpe@csd.uu.se
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ATAPI cdrecord issue 2.5.67
In-Reply-To: <1050003892.12498.45.camel@dhcp22.swansea.linux.org.uk>
References: <1049983308.888.5.camel@gregs>
	<1049984188.887.11.camel@gregs>
	<1049986391.599.6.camel@teapot.felipe-alfaro.com>
	<20030410193420.GD429@vitelus.com>
	<b74i32$58g$1@cesium.transmeta.com>
	<1050003892.12498.45.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > On Thu, 2003-04-10 at 20:53, H. Peter Anvin wrote:
 > > I think ide-scsi needs to be supported for some time going forward.
 > > After all, cdrecord, cdrdao, dvdrecord aren't going to be the only
 > > applications.
 > 
 > And far longer than that. People seem to be testing and demoing 
 > crazy things like SATA attached scanners, printers and even enclosure
 > services.

ATAPI tape drives will need ide-scsi too, unless ide-tape somehow
got repaired lately. And some people already use ide-scsi+st in
2.4 since ide-tape doesn't always work reliably.

ide-scsi isn't just for CD/DVD writers.
