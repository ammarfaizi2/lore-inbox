Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265146AbTLRNzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 08:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265145AbTLRNzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 08:55:14 -0500
Received: from intra.cyclades.com ([64.186.161.6]:16791 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265146AbTLRNzK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 08:55:10 -0500
Date: Thu, 18 Dec 2003 11:53:20 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Ian Soboroff <ian.soboroff@nist.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trivial hard lockup, SCSI, 2.4.23
In-Reply-To: <9cfiskgpqg9.fsf@rogue.ncsl.nist.gov>
Message-ID: <Pine.LNX.4.44.0312181153080.4547-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Dec 2003, Ian Soboroff wrote:

> 
> I've found that I can lock a machine running 2.4.23aa1 by trying to
> access a nonexistent SCSI device.  In other words, if a userspace
> program tries to access /dev/sdd, but no device is attached on any
> SCSI bus using that device node, the machine locks hard.
> 
> We found this when we disconnected a SCSI hardware RAID from a server,
> but forgot to remove the cron job which checked its status.
> 
> The lockup leaves no errors whatsoever in the logs.  I finally tracked
> it down with the NMI watchdog.

What did the NMI oopser report ? 

