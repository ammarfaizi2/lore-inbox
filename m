Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268904AbUIHHnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268904AbUIHHnz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 03:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268907AbUIHHnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 03:43:55 -0400
Received: from svr68.ehostpros.com ([67.15.48.48]:54988 "EHLO
	svr68.ehostpros.com") by vger.kernel.org with ESMTP id S268904AbUIHHny
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 03:43:54 -0400
From: "Amit S. Kale" <amitkale@linsyssoft.com>
Organization: LinSysSoft Technologies Pvt Ltd
To: Linux Kernel <linux-kernel@vger.kernel.org>, yakker@sourceforge.net
Subject: Generating kernel crash dumps in elf core file format
Date: Wed, 8 Sep 2004 13:13:28 +0530
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409081313.28087.amitkale@linsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr68.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linsyssoft.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are thinking of implementing the generation of linux kernel crash dumps in 
elf core file format. This will enable users to analyze kernel crash dumps 
using gdb. It should be good tool to complement KGDB. KGDB could be used 
during development stage for live kernel analysis and LKCD-GDB could be used 
with the same capabilities for analysis of customer problems and in house 
release testing.

We would like to know if people think this will be useful or they are more 
comfortable with current way of kernel panic analysis using existing LKCD.

Any ideas/suggestions/pointers to existing work in this area are most welcome.

Thanks.
-Amit Kale
