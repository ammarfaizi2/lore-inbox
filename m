Return-Path: <linux-kernel-owner+w=401wt.eu-S932112AbXAIPCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbXAIPCb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 10:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbXAIPCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 10:02:31 -0500
Received: from relay.gothnet.se ([82.193.160.251]:5170 "EHLO
	GOTHNET-SMTP2.gothnet.se" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932112AbXAIPCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 10:02:31 -0500
Message-ID: <45A3AE70.603@tungstengraphics.com>
Date: Tue, 09 Jan 2007 16:02:08 +0100
From: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@tungstengraphics.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060921)
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
CC: Dave Airlie <airlied@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Replace nopage() / nopfn() with fault()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-BitDefender-Scanner: Mail not scanned due to license constraints
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick,

We're working to slowly get the new DRM memory manager into the 
mainstream kernel.
This means we have a need for the page fault handler patch you wrote 
some time ago.
I guess we could take the no_pfn() route, but that would need a check 
for racing
unmap_mapping_range(), and other problems may arise.

What is the current status and plans for inclusion of the fault() code?

Thanks,
Thomas Hellstrom
Tungsten Graphics.



