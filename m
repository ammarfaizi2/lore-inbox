Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVC2C5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVC2C5e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 21:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVC2C5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 21:57:34 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:23787 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262162AbVC2C5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 21:57:25 -0500
Message-ID: <4248C403.1010703@comcast.net>
Date: Mon, 28 Mar 2005 21:57:07 -0500
From: Andy Stewart <andystewart@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.11.5 doesn't recognize Plextor 712 SATA DVD burner
References: <4244D169.6070504@comcast.net> <42462C4F.5040408@comcast.net>
In-Reply-To: <42462C4F.5040408@comcast.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, I took the plunge and dove into the code.  Here is what I've
discovered so far.

scsi_scan_host_selected: <1:4294967295:4294967295:4294967295>
scsi scan: INQUIRY pass 1 to host 1 channel 0 id 0 lun 0, length 36
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x1

scsi scan: INQUIRY failed with code 0x2

I don't yet know why the DVD burner is failing on the scsi INQUIRY
command.  Does anybody have any ideas?

I plan to keep looking.

Thanks,

Andy

-- 
Andy Stewart, Founder
Worcester Linux Users' Group
Worcester, MA, USA
http://www.wlug.org

