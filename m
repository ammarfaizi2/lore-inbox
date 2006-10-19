Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946588AbWJSW0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946588AbWJSW0c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 18:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946594AbWJSW0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 18:26:32 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:26 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1946590AbWJSW0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 18:26:31 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=tLBxlPXtw/oX0MaTIf4x5+KZqDLaRMFl1WLDApqQyaSto2ErjlZWwprQ3O0NTvXRXtl0wwKZxfUN3AGR11zfvYBCm5P+r2g3kOYe5axcfd/65EjdZJLDRcYqKSRa2qw6;
X-IronPort-AV: i="4.09,330,1157346000"; 
   d="scan'208"; a="100402088:sNHT15506262"
Date: Thu, 19 Oct 2006 17:26:33 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Joshua Schmidlkofer <joshua@imrlive.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recurring MegaRAID SCSI Errors
Message-ID: <20061019222633.GC7410@lists.us.dell.com>
References: <4537F7AA.4060709@imr-net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4537F7AA.4060709@imr-net.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 03:09:46PM -0700, Joshua Schmidlkofer wrote:
> We are getting errors from a MegaRAID device.  We have been able to 
> semi-consistently reproduce this by copying large files to the network.  
> This is a Dell PowerEdge 1800.
> 
> We have replaced everything in the system. 
> - 2 New RAID Cards.
> - New Memory
> - New Motherboard
> - New case.
> 
> We are currently running 2.6.17.7 - we have been upgrading slowly.  
> First due to problems with the RAID that were fixed in 15 or 16, second, 
> the numerous special XFS fixes that have been needed.
> 
> I have no idea why this is happening, and could really use some guidance.
> 
> Dell is fast running out of suggestions.  No errors except what the 
> kernel reports are being found.

Most likely you need this patch:
http://marc.theaimsgroup.com/?l=linux-scsi&m=115992186113515&w=2

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
