Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269134AbUIHLup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269134AbUIHLup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269131AbUIHLu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:50:29 -0400
Received: from svr68.ehostpros.com ([67.15.48.48]:9956 "EHLO
	svr68.ehostpros.com") by vger.kernel.org with ESMTP id S269130AbUIHLts
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:49:48 -0400
From: "Amit S. Kale" <amitkale@linsyssoft.com>
Organization: LinSysSoft Technologies Pvt Ltd
To: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Generating kernel crash dumps in elf core file format
Date: Wed, 8 Sep 2004 17:19:10 +0530
User-Agent: KMail/1.5
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, yakker@sourceforge.net,
       suparna bhattacharya <suparna@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>, akpm@osdl.org
References: <200409081313.28087.amitkale@linsyssoft.com> <1094636955.18148.8.camel@2fwv946.in.ibm.com>
In-Reply-To: <1094636955.18148.8.camel@2fwv946.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409081719.10253.amitkale@linsyssoft.com>
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

On Wednesday 08 Sep 2004 3:20 pm, Vivek Goyal wrote:
> Hi Amit,
>
> We are already working in this direction. Kexec based crash dump
> approach exports a device interface to read/save the crash dump in elf
> core file format and user shall be able to analyze the dumps using gdb.
>
> Initial set of patches were posted by Hari on LKML for review. Please
> have a look at following thread.
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109274443023485&w=2
>
> Very soon Hari is going to post the final set of patches to be included
> in -mm tree.

Hi Vivek,

Nice!

Could you also tell us about the state of user level utilities required to 
save dumps in elf format? Are they going to be available any time soon?

Thanks.
-Amit

>
> Thanks
> Vivek
>
> On Wed, 2004-09-08 at 13:13, Amit S. Kale wrote:
> > Hi,
> >
> > We are thinking of implementing the generation of linux kernel crash
> > dumps in elf core file format. This will enable users to analyze kernel
> > crash dumps using gdb. It should be good tool to complement KGDB. KGDB
> > could be used during development stage for live kernel analysis and
> > LKCD-GDB could be used with the same capabilities for analysis of
> > customer problems and in house release testing.
> >
> > We would like to know if people think this will be useful or they are
> > more comfortable with current way of kernel panic analysis using existing
> > LKCD.
> >
> > Any ideas/suggestions/pointers to existing work in this area are most
> > welcome.
> >
> > Thanks.
> > -Amit Kale
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

