Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271420AbTHDJfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 05:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271606AbTHDJfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 05:35:41 -0400
Received: from host81-136-144-97.in-addr.btopenworld.com ([81.136.144.97]:41640
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP id S271420AbTHDJfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 05:35:40 -0400
Subject: Re: [Q] Question about memory access
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: "Cho, joon-woo" <jwc@core.kaist.ac.kr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00a001c35a58$02c20f00$a5a5f88f@core8fyzomwjks>
References: <00a001c35a58$02c20f00$a5a5f88f@core8fyzomwjks>
Content-Type: text/plain
Message-Id: <1059989725.392.2.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 04 Aug 2003 10:35:25 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-04 at 08:14, Cho, joon-woo wrote:
> If someone want to transfer large data from some device to memory, he may
> use DMA method.
> 
> At this point, i am confused.
> 
> I think that only one process can access physical memory(RAM) at a time.

The DMA controller is a dedicated piece of hardware that copies the data
from devices to RAM. This means that other processes can use the CPU
while the DMA is in progress. That is the whole point of DMA.

-- 
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D


