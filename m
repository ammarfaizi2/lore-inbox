Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263420AbTCNRZ6>; Fri, 14 Mar 2003 12:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263423AbTCNRZ5>; Fri, 14 Mar 2003 12:25:57 -0500
Received: from magic-mail.adaptec.com ([208.236.45.100]:58784 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S263420AbTCNRZV>; Fri, 14 Mar 2003 12:25:21 -0500
Date: Fri, 14 Mar 2003 10:35:19 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Terry Barnaby <terry@beam.ltd.uk>, Michael Madore <mmadore@aslab.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reproducible SCSI Error with Adaptec 7902
Message-ID: <526590000.1047663319@aslan.btc.adaptec.com>
In-Reply-To: <3E7200B7.6000907@beam.ltd.uk>
References: <3E71B629.60204@beam.ltd.uk> <1999490000.1047653585@aslan.scsiguy.com> <3E7200D1.3030207@aslab.com> <3E7200B7.6000907@beam.ltd.uk>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Michael,
> 
> The Seagate ST336607LW has firmware: 0004.
> Seagate have stated to me that this is the latest.
> They have also stated to me:
> 
>   Issuing an unrecognized or illegal command to the drive can cause the
>   drive to go into a hardware fault mode where it will no longer respond,
>   and may or may not respond to a SCSI BUS reset. It seems, in this case,
>   the drive will no longer respond to any commands issued by the
>   controller.
> 
> Is this "feature" now common on SCSI drives ????

This would be a terrible violation of the SCSI spec.  Perhaps someone
forgot to disable a debugging mode in the drive?

--
Justin

