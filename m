Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTLXCQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 21:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTLXCQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 21:16:49 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:7879 "EHLO amber.ccs.neu.edu")
	by vger.kernel.org with ESMTP id S263158AbTLXCQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 21:16:48 -0500
Subject: Re: Question about badblocks on SWAP partitions
From: Stan Bubrouski <stan@ccs.neu.edu>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20031224004108.GA15256@win.tue.nl>
References: <1072225317.2947.153.camel@duergar>
	 <20031224004108.GA15256@win.tue.nl>
Content-Type: text/plain
Message-Id: <1072232202.2947.158.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 23 Dec 2003 21:16:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-23 at 19:41, Andries Brouwer wrote:
> swapoff?
> 

Ok problem solved, I totally forgot about badblocks.  It's been soooo
long since I've had a disk with actual physical errors (I've had my
share of dead disks however!).  Anyways I just ran badblocks and remade
the swap partition avoiding those blocks.

Thanks to all the people who mailed me off the list to remind of this
simple solution.

Best Regards,

sb

