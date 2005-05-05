Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVEEPBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVEEPBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 11:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVEEPBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 11:01:45 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:16020 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262126AbVEEPBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 11:01:43 -0400
Subject: Re: very strange issue with sata,<4G Ram, and ext3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rick Warner <rick@microway.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200505041529.54502.rick@microway.com>
References: <200504281216.08026.rick@microway.com>
	 <1114728503.24687.248.camel@localhost.localdomain>
	 <200504291045.58893.rick@microway.com>
	 <200505041529.54502.rick@microway.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1115305221.19844.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 May 2005 16:00:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-05-04 at 20:29, Rick Warner wrote:
> Just sending out a ping on this.. anyone have any ideas?

The best I can think of right now in going forward is check
	32 v 64 bit kernel
	32bit Highmem aware kernel v 32bit non highmem (1GB limit) kernel
	PATA boot v SATA boot v Network boot

just to try and find any patterns.

