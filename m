Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261436AbTCONBP>; Sat, 15 Mar 2003 08:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261440AbTCONBP>; Sat, 15 Mar 2003 08:01:15 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:18319 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261436AbTCONBO>; Sat, 15 Mar 2003 08:01:14 -0500
Date: Sat, 15 Mar 2003 14:11:48 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Terry Barnaby <terry@beam.ltd.uk>
Cc: Michael Madore <mmadore@aslab.com>, "Justin T. Gibbs" <gibbs@scsiguy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Reproducible SCSI Error with Adaptec 7902
Message-ID: <20030315141148.A626@nightmaster.csn.tu-chemnitz.de>
References: <3E71B629.60204@beam.ltd.uk> <1999490000.1047653585@aslan.scsiguy.com> <3E7200D1.3030207@aslab.com> <3E7200B7.6000907@beam.ltd.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3E7200B7.6000907@beam.ltd.uk>; from terry@beam.ltd.uk on Fri, Mar 14, 2003 at 04:17:59PM +0000
X-Spam-Score: -32.5 (--------------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18uBSG-0004at-00*w9dLt4AFKo2*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 04:17:59PM +0000, Terry Barnaby wrote:
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

Could we add a KERN_WARNING printk in sd.c quoting/referencing
this message on inquiry detecting this device? 

So sysadmins who are used to SCSI being robust could return the
drive to their vendors in exchange to a drive working along the
SCSI specs after reading this message.

Thanks in the name of the sysadmins.

Regards

Ingo Oeser
