Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319239AbSIFQRU>; Fri, 6 Sep 2002 12:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319229AbSIFQRT>; Fri, 6 Sep 2002 12:17:19 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:41466 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319194AbSIFQRR>; Fri, 6 Sep 2002 12:17:17 -0400
Date: Fri, 6 Sep 2002 08:34:37 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Oktay Akbal <oktay.akbal@s-tec.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: qlogic failover multipath
Message-ID: <20020906153437.GA2164@beaverton.ibm.com>
Mail-Followup-To: Oktay Akbal <oktay.akbal@s-tec.de>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <Pine.LNX.4.44.0209051043570.2844-100000@omega.s-tec.de> <Pine.LNX.4.44.0209061142150.12655-100000@omega.s-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209061142150.12655-100000@omega.s-tec.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oktay Akbal [oktay.akbal@s-tec.de] wrote:
> Hello,
> 
> we do have some Problems with some qlogic 2202f fibrechannel card.
> When trying to use failover via plugging out some cable or using
> qlogics sansurfer to set an alternate path, there seem to be no errors,
> but everything works extremly slow and does not recover.
> 
> This was used with driver 6.0b23 as from suse kernel 2.4.18.
> 
> When trying 6.1b2 or b5 the disks get recognized as multiple scsi-disks,
> is this wanted for use with md multipath personality ?
> Is there a way to enable previos behavior ?

You can edit the qla_settings.h file and set MPIO_SUPPORT to 1 or I
believe if you use the qla2x00src-v6.1b5-fo archive that this should
already be set to 1.

-Mike
-- 
Michael Anderson
andmike@us.ibm.com

