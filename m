Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSFJREZ>; Mon, 10 Jun 2002 13:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSFJREY>; Mon, 10 Jun 2002 13:04:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:54680 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315536AbSFJREV>; Mon, 10 Jun 2002 13:04:21 -0400
Date: Mon, 10 Jun 2002 10:04:11 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: manjuanth n <manju_tt@yahoo.com>
Cc: Michael Clark <michael@metaparadigm.com>, linux-kernel@vger.kernel.org
Subject: Re: need help
Message-ID: <20020610100411.A9734@eng2.beaverton.ibm.com>
In-Reply-To: <3D025E50.1020506@metaparadigm.com> <20020610142139.50949.qmail@web14405.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 07:21:39AM -0700, manjuanth n wrote:
> Dear  Michael,
> 
> Thanks  for the solution, but  my  problem still 
> remains  unresolved.  I  added the following lines  to
>  scsi_scan.c  and recompiled

>         {"HITACHI", "OPEN E*4", "*", BLIST_FORCELUN},

>  the  out put of the scsi venders  are  as follows
>  cat  /proc/scsi/scsi

> Host: scsi3 Channel: 00 Id: 00 Lun: 00
>   Vendor: HITACHI  Model: OPEN-E*4         Rev: 0116
>   Type:   Processor                        ANSI SCSI
> revision: 02

> 	{"HITACHI", "OPEN E*4", "*", BLIST_FORCELUN},

It looks like you are missing a '-' in the above.

-- Patrick Mansfield
