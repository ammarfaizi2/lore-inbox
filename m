Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264951AbTF0Xrt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 19:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264952AbTF0Xrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 19:47:49 -0400
Received: from windsormachine.com ([206.48.122.28]:62992 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S264951AbTF0Xrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 19:47:48 -0400
Date: Fri, 27 Jun 2003 20:01:59 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Larry McVoy <lm@bitmover.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
In-Reply-To: <20030627235150.GA21243@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0306271959190.12141-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Jun 2003, Larry McVoy wrote:

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

3h - MEDIUM ERROR: indicates that the command terminated with a
non-recovered error caused by a flaw in the medium (the medium depends on
the device type)

Have to lookup the asc and ascq with ibm, as it varies by manufacturer.

0Bh 01h DTLPWRSOMCAE Warning - specified temperature exceeded

My guess is that you're seeing a temperature warning on a drive.

Which makes sense with the overheated server room.

Mike

