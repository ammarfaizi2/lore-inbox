Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277024AbRKSJvF>; Mon, 19 Nov 2001 04:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277012AbRKSJuy>; Mon, 19 Nov 2001 04:50:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50955 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276761AbRKSJuo>; Mon, 19 Nov 2001 04:50:44 -0500
Subject: Re: Maximum (efficient) partition sizes for various filesystem types...
To: joelbeach@optushome.com.au (Joel Beach)
Date: Mon, 19 Nov 2001 09:58:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001401c170d3$ea40cc10$1e50a8c0@kinslayer> from "Joel Beach" at Nov 19, 2001 07:26:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E165lCN-00061N-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For instance, the Debian guide says that, due to Ext2 efficiency, partitions
> greater than 6-7GB shouldn't be created. Is this true for Ext3/ReiserFS.

I've run several 45-200Gb ext2 and ext3 partitions with no problem. I'm not
sure what the origin of the Debian guide comemnt is but I've never heard
it from an ext2 developer

Obviously pick a journalled fs for big partitions 8)
