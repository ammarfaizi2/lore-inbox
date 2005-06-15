Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVFOXBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVFOXBu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 19:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVFOW7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:59:49 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:59074 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261626AbVFOW6x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:58:53 -0400
Subject: RE: 2.6.12-rc6-mm1 & 2K lun testing
From: Badari Pulavarty <pbadari@us.ibm.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <200506152139.j5FLd3g26510@unix-os.sc.intel.com>
References: <200506152139.j5FLd3g26510@unix-os.sc.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1118874915.4301.461.camel@dyn9047017072.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jun 2005 15:35:15 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-15 at 14:39, Chen, Kenneth W wrote:
> Badari Pulavarty wrote on Wednesday, June 15, 2005 10:36 AM
> > I sniff tested 2K lun support with 2.6.12-rc6-mm1 on
> > my AMD64 box. I had to tweak qlogic driver and
> > scsi_scan.c to see all the luns.
> > 
> > (2.6.12-rc6 doesn't see all the LUNS due to max_lun
> > issue - which is fixed in scsi-git tree).
> > 
> > Test 1:
> > 	run dds on all 2048 "raw" devices - worked
> > great. No issues.
> 
> Just curious, how many physical disks do you have for this test?
> 

2048 luns are created using NetApp FAS 270C - which has 28 drives.
I am accessing the luns through fiber channel.


Thanks,
Badari

