Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422677AbWBNTcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbWBNTcf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422714AbWBNTcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:32:35 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:61966 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1422677AbWBNTce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:32:34 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: Is my SATA/400GB drive dying?
Date: Tue, 14 Feb 2006 19:30:45 +0000
User-Agent: KMail/1.9.1
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0602130658110.21652@p34> <Pine.LNX.4.64.0602132018290.2607@p34> <20060214104345.GM3209@harddisk-recovery.com>
In-Reply-To: <20060214104345.GM3209@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602141930.45368.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 10:43, Erik Mouw wrote:
> On Mon, Feb 13, 2006 at 08:18:47PM -0500, Justin Piszcz wrote:
> > Still get the errors:
> >
> > [ 2311.980127] ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ
> > 0xb/00/00
> > [ 2311.980134] ata3: status=0x51 { DriveReady SeekComplete Error }
> > [ 2311.980138] ata3: error=0x04 { DriveStatusError }
>
> FWIW, this could be related to smartctl trying to monitor the disk.
> Try this:
>
>   smartctl -d ata -a /dev/sdX
>
> If that complains about SMART being disabled, enable it with:
>
>   smartctl -d ata -e /dev/sdX

Are you sure this isn't something obvious like an insufficiently large power 
supply in the system? I've had strange SATA errors before because I was 
running 4 HDs and a 6600GT on a 360W PSU.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
