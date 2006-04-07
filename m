Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWDGIsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWDGIsT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 04:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWDGIsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 04:48:19 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:20197 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932392AbWDGIsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 04:48:17 -0400
Message-ID: <4436271B.4020808@aitel.hist.no>
Date: Fri, 07 Apr 2006 10:47:23 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
CC: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Hanging ext3 or USB, linux 2.6.16-rc6-mm2
References: <20060327210514.GA24421@aitel.hist.no> <20060406184712.GA5458@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060406184712.GA5458@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara wrote:

>>Could this be a ext3 problem due to the small journal or something?
>>
>>Or is a usb problem more likely? "Dmesg" shows an
>>usb disconnect sometime after I mounted that filesystem,
>>but it seems to be usblp0 which looks like the printer to me.
>>    
>>
>  I'd guess it is some USB/block layer problem. If just ext3 hung, then
>you would not see [usb-storage] and similar hung. I would need to see
>where each process hung to tell more..
>
You are right, it is block layer for I have seen problems with
vfat formatted compactflash too now.  On my home machine, the
problems are intermittent.  The hang can happen after
writing almost one GB, or it can happen early, in "mount"

I also have a via epia board that consistently fails to use
its compactflash reader, but that one is cardbus, not usb.

Helge Hafting
