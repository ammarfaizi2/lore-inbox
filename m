Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbTJFRP7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264044AbTJFRP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:15:59 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:33186 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264043AbTJFRP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:15:57 -0400
Date: Mon, 6 Oct 2003 13:13:21 -0400
From: Ben Collins <bcollins@debian.org>
To: Sraphim <sraphim@mofd.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SBP2 does not work with Apple iPod in versions later than 2.4.19
Message-ID: <20031006171321.GM556@phunnypharm.org>
References: <200310061149.28426.sraphim@mofd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310061149.28426.sraphim@mofd.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ieee1394: Node added: ID:BUS[0-01:1023]  GUID[000a2700020c8630]
> ieee1394: The root node is not cycle master capable; selecting a new root node 
> and resetting...
> ieee1394: Node changed: 0-01:1023 -> 0-00:1023
> ieee1394: Node changed: 0-00:1023 -> 0-01:1023
> sbp2: $Rev: 1010 $ Ben Collins <bcollins@debian.org>
> scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
> ieee1394: sbp2: Logged into SBP-2 device
> ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]
> 
> I am sure that I compiled in SCSI support, and SCSI disk/CDROM/tape/generic 
> support into the kernel. I have also compiled in support for ieee1394. No 
> matter what, it does not work correctly. Am I missing something? Or perhaps 
> this new SBP2 module requires me to pass something to it in order to enable 
> the SCSI emulation or something?

People really should start making a habit of reading documentation when
upgrading things, especially when they know they have a problem. If you
read the SBP2 section on linux1394.org, you'll see where it says that
later versions of 2.4 need the rescan-scsi-bus.sh script. It also
explains why, and links to the script.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
