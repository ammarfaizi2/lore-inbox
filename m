Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWJBTrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWJBTrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWJBTrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:47:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25472 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964850AbWJBTrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:47:13 -0400
Date: Mon, 2 Oct 2006 15:47:11 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.18 ext3 panic.
Message-ID: <20061002194711.GA1815@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure what exactly happened here. Was running fsx on ext3 over 2 disk raid0,
and running a yum update. Box locked up solid after a few minutes..
http://www.codemonkey.org.uk/junk/DSC00747.JPG

The unwinder getting stuck meant I lost the top of the trace though.
(I have backporting the .19 fixes to .18 on my todo unless someone
 beats me to it and they end up in -stable).

Will try to reproduce with a serial console hooked up.

	Dave

-- 
http://www.codemonkey.org.uk
