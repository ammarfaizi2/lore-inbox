Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261422AbSJDBjJ>; Thu, 3 Oct 2002 21:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbSJDBjJ>; Thu, 3 Oct 2002 21:39:09 -0400
Received: from cogent.ecohler.net ([216.135.202.106]:53395 "EHLO
	cogent.ecohler.net") by vger.kernel.org with ESMTP
	id <S261422AbSJDBjI>; Thu, 3 Oct 2002 21:39:08 -0400
Date: Thu, 3 Oct 2002 21:44:39 -0400
From: lists@sapience.com
To: linux-kernel@vger.kernel.org
Subject: Re: Oops (ide?) with 2.4.20-pre8-ac3 at boot on scsi only smp
Message-ID: <20021004014438.GA5937@sapience.com>
References: <20021002040135.GA6652@sapience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20021002040135.GA6652@sapience.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Here are the things I tried to see if I could make headway - none
  helped - still OOPS at boot:

     o Compiled with no highmem   - 

     o Compiled without SMP

     o removed  hdd=ide-scsi boot option

     o added ide0=nodma ide1=nodma boot option

     o switched to aic7xxx as a module using initrd

   Still crashes - any suggestions on what I should try next?

   Thanks,

   gene/


On Wed, Oct 02, 2002 at 12:01:35AM -0400, lists@sapience.com wrote:
> 
> 
>    hi,
> 
>    First report - please let me know what more 
>    I can do to help.
> 
>    gene/
> 
>   
>    (0) 2.4.20-pre8-ac3 - oops at boot - scsi disks only - 
>        no IDE disks - smp.
> 
>    (1) Fresh build of 2.4.20-pre8-ac3 - aic7xxx driver in kernel -
>       oops'es at boot in IDE code with  'Unable to handle kernel NULL pointer'
>       Does have IDE cdrom and CDRW (latter booted with ide-scsi)
> 
>       Machine is dual P4 with 1 Gb memory and kernel compiled with 4Gb memory
>       model. Runs fine under stock redhat 2.4.18-10 kernel
> 
