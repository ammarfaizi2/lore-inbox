Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbTF0Xp3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 19:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264944AbTF0Xp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 19:45:29 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:8869 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264942AbTF0Xp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 19:45:28 -0400
Date: Fri, 27 Jun 2003 16:55:19 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Larry McVoy <lm@work.bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CaT <cat@zip.com.au>, nick@snowman.net, Larry McVoy <lm@bitmover.com>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
Message-ID: <20030627165519.A1887@beaverton.ibm.com>
References: <20030627145727.GB18676@work.bitmover.com> <Pine.LNX.4.21.0306271228200.17138-100000@ns.snowman.net> <20030627163720.GF357@zip.com.au> <1056732854.3172.56.camel@dhcp22.swansea.linux.org.uk> <20030627235150.GA21243@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030627235150.GA21243@work.bitmover.com>; from lm@bitmover.com on Fri, Jun 27, 2003 at 04:51:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 04:51:50PM -0700, Larry McVoy wrote:
> Anyone know what this means?  This is from the supposedly superduper
> rackspace machine which has a Mylex SCSI RAID (see below):
> 
> DAC960#0: Physical Device 0:0 Sense Data Received
> DAC960#0: Physical Device 0:0 Request Sense: Sense Key = 3, ASC = 11, ASCQ = 00
> DAC960#0: Physical Device 0:0 Request Sense: Information = 0380A6CA 00000000
> DAC960#0: Physical Device 0:0 Sense Data Received
> DAC960#0: Physical Device 0:0 Request Sense: Sense Key = 3, ASC = 11, ASCQ = 00
> DAC960#0: Physical Device 0:0 Request Sense: Information = 0380A6CA 00000000
> DAC960#0: Physical Device 0:0 Errors: Parity = 0, Soft = 0, Hard = 0, Misc = 0
> DAC960#0: Physical Device 0:0 Errors: Timeouts = 0, Retries = 0, Aborts = 0, Predicted = 0

Sense key 3 is MEDIUM ERROR. ASC 11 ASCQ 0 is an unrecovered medium error.

-- Patrick Mansfield
