Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263185AbVGAETY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbVGAETY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 00:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbVGAETY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 00:19:24 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:65487 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S263185AbVGAETW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 00:19:22 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <42C4C291.2010508@s5r6.in-berlin.de>
Date: Fri, 01 Jul 2005 06:12:01 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
CC: Ben Collins <bcollins@debian.org>, rbrito@ime.usp.br,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Problems with Firewire and -mm kernels
References: <20050628161500.GA25788@phunnypharm.org> <20050701010157.GA7877@ime.usp.br> <20050701011226.GB2067@phunnypharm.org> <20050701024432.GA18150@ime.usp.br> <20050701031801.GA12915@phunnypharm.org>
In-Reply-To: <20050701031801.GA12915@phunnypharm.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.556) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> However, there is a huge set of changes to sbp2. One thing that sticks out
> is the entire sbp2_check_sbp2_command() function being ripped out. There's
> some changes related to TYPE_SDAD devices (where did this come from?).

The TYPE_SDAD -> TYPE_RBC changes come from the scsi maintainers. Here 
is the related discussion from May: 'TYPE_RBC cache fixes (sbp2.c 
affected)', http://marc.theaimsgroup.com/?t=111620896500001

(Back then I wanted to test their patch but did not find the time.)
-- 
Stefan Richter
-=====-=-=-= -=== ----=
http://arcgraph.de/sr/
