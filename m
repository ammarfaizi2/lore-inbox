Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUBEMu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 07:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbUBEMu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 07:50:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37051 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265170AbUBEMuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 07:50:52 -0500
Date: Thu, 5 Feb 2004 13:50:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Patrick Dohman <pdohman@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATAPI device errors
Message-ID: <20040205125050.GA11683@suse.de>
References: <1075976185.1369.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075976185.1369.20.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05 2004, Patrick Dohman wrote:
> My CDROM & CDRW are problematic. I am running a 2.4.24 kernel. I suspect
> a hardware problem but I am unsure if the problem lies with the CDROM,
> CDRW or the IDE/ATAPI controler. Basically the the issue boils down to
> having one or both of the drives fall offline after a day or two of
> uptime. My logs are spammed with this.
> 
> :hdd: packet command error: status=0x51 { DriveReady SeekComplete Error}
> :hdd: packet command error: error=0x40
> :ATAPI device hdd:
> :Error: Hardware error -- (Sense key=0x04)
> :(vendor-specific error) -- (asc=0x90, ascq=0x00)
> :The failed "Test Unit Ready" packet command was: 
> :"00 00 00 00 00 00 00 00 00 00 00 00 "
> 
> Is there a more verbose form of logging I can enable. Any clarification
> is very much appreciated. 

Only the vendor of that drive can tell you what it means, but you are
most likely correct in assuming it's hardware reror.

-- 
Jens Axboe

