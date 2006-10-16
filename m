Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750699AbWJPMuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbWJPMuh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 08:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWJPMuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 08:50:37 -0400
Received: from dhost002-90.dex002.intermedia.net ([64.78.20.228]:52569 "EHLO
	dhost002-90.dex002.intermedia.net") by vger.kernel.org with ESMTP
	id S1750699AbWJPMuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 08:50:37 -0400
Message-ID: <45337FE3.8020201@qlusters.com>
Date: Mon, 16 Oct 2006 14:49:39 +0200
From: Constantine Gavrilov <constg@qlusters.com>
Reply-To: Constantine Gavrilov <constg@qlusters.com>
Organization: Qlusters
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Would SSI clustering extensions be of interest to kernel community?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2006 12:50:34.0259 (UTC) FILETIME=[ABA54E30:01C6F121]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have implemented SSI (single system image) clustering extensions to 
Linux kernel in the form of a loadable module.

It roughly mimics OpenMosix model of deputy/remote split (migrated 
processes leave a stub on the node where they were born and depend on 
the "home" node for IO).

The implementation shares no code with Mosix/Open Mosix (was written 
from scratch), is much smaller, and is easily portable to multiple 
architectures.

We are considering publication of this code and forming an open source 
project around it.

I have two questions to the community:

1) Is community interested in using this code? Do users require SSI 
product in the era when everybody is talking about partitioning of 
machines and not clustering?
2) Are kernel maintainers interested in clustering extensions to Linux 
kernel? Do they see any value in them? (Our code does not require kernel 
changes, but we are willing to submit it for inclusion if there is 
interest.)

Please CC me and the list when replying.

-- 
----------------------------------------
Constantine Gavrilov
Kernel Developer
Qlusters Software Ltd
1 Azrieli Center, Tel-Aviv
Phone: +972-3-6081977
Fax:   +972-3-6081841
----------------------------------------

