Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269057AbUIHJkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269057AbUIHJkQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269076AbUIHJkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:40:15 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:45207 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S269057AbUIHJjb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:39:31 -0400
Subject: Re: Generating kernel crash dumps in elf core file format
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Amit S. Kale" <amitkale@linsyssoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, yakker@sourceforge.net,
       suparna bhattacharya <suparna@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>, akpm@osdl.org
In-Reply-To: <200409081313.28087.amitkale@linsyssoft.com>
References: <200409081313.28087.amitkale@linsyssoft.com>
Content-Type: text/plain
Organization: 
Message-Id: <1094636955.18148.8.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Sep 2004 15:20:14 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

We are already working in this direction. Kexec based crash dump
approach exports a device interface to read/save the crash dump in elf
core file format and user shall be able to analyze the dumps using gdb.

Initial set of patches were posted by Hari on LKML for review. Please
have a look at following thread.

http://marc.theaimsgroup.com/?l=linux-kernel&m=109274443023485&w=2

Very soon Hari is going to post the final set of patches to be included
in -mm tree.

Thanks
Vivek

 
On Wed, 2004-09-08 at 13:13, Amit S. Kale wrote:
> Hi,
> 
> We are thinking of implementing the generation of linux kernel crash dumps in 
> elf core file format. This will enable users to analyze kernel crash dumps 
> using gdb. It should be good tool to complement KGDB. KGDB could be used 
> during development stage for live kernel analysis and LKCD-GDB could be used 
> with the same capabilities for analysis of customer problems and in house 
> release testing.
> 
> We would like to know if people think this will be useful or they are more 
> comfortable with current way of kernel panic analysis using existing LKCD.
> 
> Any ideas/suggestions/pointers to existing work in this area are most welcome.
> 
> Thanks.
> -Amit Kale
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

