Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288166AbSAHRBG>; Tue, 8 Jan 2002 12:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288173AbSAHRAq>; Tue, 8 Jan 2002 12:00:46 -0500
Received: from aef.wh.Uni-Dortmund.DE ([129.217.129.132]:52983 "EHLO
	ReneEngelhard.local") by vger.kernel.org with ESMTP
	id <S288166AbSAHRAk>; Tue, 8 Jan 2002 12:00:40 -0500
Date: Tue, 8 Jan 2002 17:58:02 +0100
From: Rene Engelhard <mail@rene-engelhard.de>
To: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Getting ScanLogic USB-ATAPI Adapter to work
Message-ID: <20020108175802.A8011@rene-engelhard.de>
Mail-Followup-To: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020107211757.A4196@rene-engelhard.de> <3C3AE450.E3255D64@loewe-komp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3C3AE450.E3255D64@loewe-komp.de>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key: http://www.rene-engelhard.de/gnupg/mykey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Wächtler wrote:
> 
> I sent a patch to unusual_devs.h but didn't get any response yet.
> I need to set "CONFIG_SCSI_MULTI_LUN=y" and use the second device for 
> CompactFlash.
> No other needed change here:
> 
> 
> UNUSUAL_DEV(  0x04ce, 0x0002, 0x0074, 0x0074,
>                 "ScanLogic",
>                 "SL11R-IDE",
>                 US_SC_SCSI, US_PR_BULK, NULL,
>                 US_FL_FIX_INQUIRY),

Yes, I saw it in the unusual_devs.h in 2.5.2-pre8 and above but it
does not help to get my mentioned device working.

My patch does.

Rene
