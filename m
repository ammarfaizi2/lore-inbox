Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271230AbTHCSXF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 14:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271231AbTHCSXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 14:23:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52905 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271230AbTHCSXD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 14:23:03 -0400
Message-ID: <3F2D52FB.5040304@pobox.com>
Date: Sun, 03 Aug 2003 14:22:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Erik Steffl <steffl@bigfoot.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA HD 137GB limitation?
References: <3F1F33B0.4070701@bigfoot.com> <20030724171253.GD5695@gtf.org> <3F201AD0.1020704@bigfoot.com>
In-Reply-To: <3F201AD0.1020704@bigfoot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just realized, 2.4 kernels don't support scsi's READ_CAPACITY_16, nor 
64-bit sector_t on a 32-bit processor.

Can you test Alan Cox's 2.6.0-test-ac tree?  I bet the 137GB limitation 
may disappear there.

	Jeff




