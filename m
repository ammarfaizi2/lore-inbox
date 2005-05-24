Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVEXDRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVEXDRH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 23:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVEXDRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 23:17:07 -0400
Received: from opersys.com ([64.40.108.71]:65286 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261323AbVEXDRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 23:17:03 -0400
Message-ID: <42929F2F.8000101@opersys.com>
Date: Mon, 23 May 2005 23:27:43 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Jens Axboe <axboe@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd vs. DMA
References: <1116891772.30513.6.camel@gaston>
In-Reply-To: <1116891772.30513.6.camel@gaston>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin Herrenschmidt wrote:
> hdb: command error: status=0x51 { DriveReady SeekComplete Error }
> hdb: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
> ide: failed opcode was: unknown
> end_request: I/O error, dev hdb, sector 42872

Got plenty of these an old Dell Optiplex GX1 (PIII-450) with
vanilla FC3. ... you've got to wonder when the kernel says there
are bad sectors on a CD (?) and then they disappear with:
hdparm -d0 /dev/hdc

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
