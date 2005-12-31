Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVLaMGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVLaMGw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 07:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbVLaMGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 07:06:52 -0500
Received: from [81.2.110.250] ([81.2.110.250]:1995 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751326AbVLaMGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 07:06:51 -0500
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu>
	 <20051228001047.GA3607@dmt.cnet>
	 <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu>
	 <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu>
	 <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 31 Dec 2005 12:08:21 +0000
Message-Id: <1136030901.28365.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-12-30 at 17:48 -0800, Chris Stromsoe wrote:
> scsi0:0:0:0: Attempting to queue an ABORT message
> CDB: 0x12 0x0 0x0 0x0 0xff 0x0
> scsi0:0:0:0: Command already completed
> aic7xxx_abort returns 0x2002

IRQ routing by the look of that trace. Make sure that if you are using
2.4.x you have ACPI disabled and see it looks any better

