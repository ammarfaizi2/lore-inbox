Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbTCEVLi>; Wed, 5 Mar 2003 16:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbTCEVLi>; Wed, 5 Mar 2003 16:11:38 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:19209 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S264867AbTCEVLf>; Wed, 5 Mar 2003 16:11:35 -0500
Date: Wed, 5 Mar 2003 16:21:48 -0500
From: Ben Collins <bcollins@debian.org>
To: Sebastian Zimmermann <sebastian@expires1203.datenknoten.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ieee1394: sbp2: sbp2util_allocate_request_packet
Message-ID: <20030305212148.GB552@phunnypharm.org>
References: <1046898487.3493.24.camel@coruscant.datenknoten.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046898487.3493.24.camel@coruscant.datenknoten.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 10:08:08PM +0100, Sebastian Zimmermann wrote:
> Hello,
> 
> I have a problem using an external firewire harddrive. When writing to
> the disk (badblocks -w) I get an error message about every minute:
> 
> kernel: ieee1394: sbp2: sbp2util_allocate_request_packet - no packets
> available!
> kernel: ieee1394: sbp2: sbp2util_allocate_write_request_packet failed
> kernel: ieee1394: sbp2: aborting sbp2 command
> kernel: Write (10) 00 09 51 b4 4a 00 00 fe 00
> 
> This by itself is - except for small pauses once and then - no problem.
> But when writing much data (dd for 40 GB), it gets worse after some
> time:

This is fixed the patch I send against -pre5. You can use the
branches/linux-2.4 directory in the repo as a direct replacement for
drivers/ieee1394 in fact (www.linux1394.org).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
