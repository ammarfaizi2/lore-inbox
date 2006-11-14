Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966397AbWKNWGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966397AbWKNWGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966402AbWKNWGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:06:19 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:32162 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S966397AbWKNWGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:06:18 -0500
Message-ID: <455A3DEA.7030101@cfl.rr.com>
Date: Tue, 14 Nov 2006 17:06:34 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: What ever happened to the new flush mount option?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Nov 2006 22:06:33.0570 (UTC) FILETIME=[2552F420:01C70839]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14814.000
X-TM-AS-Result: No--5.084600-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What ever happened to the patch proposed last year in this thread:

http://www.ussg.iu.edu/hypermail/linux/kernel/0512.3/0050.html

It doesn't appear to have been merged into the kernel.  Was it forgotten 
about?  This seems to be a rather important change given the current 
brokenness with removable media.  Users expect to be able to unplug 
their usb memory stick after they save their documents and exit the 
application.  They can not do this without corruption due to aggressive 
caching, and the sync mount option causes far too many writes, killing 
performance and in some cases, destroying media by prematurely wearing 
out the fat sectors.

Can we get this patch revived?

