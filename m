Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWAIVmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWAIVmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWAIVmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:42:13 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:46556 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750765AbWAIVmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:42:12 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43C2D899.2080302@s5r6.in-berlin.de>
Date: Mon, 09 Jan 2006 22:41:45 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: sbp2 address space
References: <43BFAEE9.7090707@s5r6.in-berlin.de>
In-Reply-To: <43BFAEE9.7090707@s5r6.in-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.798) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> Does PCIe provide a bigger host bus address space than PCI?

PCIe obviously supports 64bit addressing. Do newer revisions of 
conventional PCI support more than 32bit addressing? What about PCI-X? TIA.

[sbp2 depends on a <= 32bit address space of the host bus. Single-chip 
FireWire PCIe adapters are available now but I believe they are merely 
based on a PCI FireWire link layer controller plus PCI-PCIe bridge.]
-- 
Stefan Richter
-=====-=-==- ---= -=--=
http://arcgraph.de/sr/
