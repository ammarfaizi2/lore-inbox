Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWIDV0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWIDV0j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 17:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWIDV0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 17:26:39 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:29093 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964986AbWIDV0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 17:26:38 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44FC99F9.9020801@s5r6.in-berlin.de>
Date: Mon, 04 Sep 2006 23:26:17 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ben Collins <bcollins@ubuntu.com>
Subject: Re: [PATCH 2.6.18-rc4 1/5] ieee1394: sbp2: workaround for write protect
 bit of Initio firmware
References: <tkrat.bbaf8d081f6a31b7@s5r6.in-berlin.de> <tkrat.94cecc462a778dde@s5r6.in-berlin.de> <Pine.LNX.4.64.0608271308360.27779@g5.osdl.org> <20060828092429.GA8980@infradead.org> <44F2D70F.30102@s5r6.in-berlin.de> <44FC8AAC.10609@s5r6.in-berlin.de> <Pine.LNX.4.64.0609041348220.27779@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609041348220.27779@g5.osdl.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Btw, somebody should tell the Oracle Endpoint people to get their target 
> client to support the 6-byte version too, no? Anybody who knows that team?

At least OS X doesn't complain. I haven't tested Linux-to-Linux yet ---
but that's what Endpoint was obviously written for in the first place,
potentially with multiple 1394 cards on the target and multiple
concurrent initiators. Manish Singh is the author; he will get feedback
from me. I think he was around at linux1394-devel occasionally.
BTW, Endpoint could be reused to build a transport driver for the
upcoming generic SCSI target framework.
svn co http://oss.oracle.com/projects/endpoint/src/
-- 
Stefan Richter
-=====-=-==- =--= --=--
http://arcgraph.de/sr/
