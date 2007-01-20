Return-Path: <linux-kernel-owner+w=401wt.eu-S932880AbXATCru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932880AbXATCru (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 21:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932876AbXATCru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 21:47:50 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:4972 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932880AbXATCrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 21:47:49 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
Date: Sat, 20 Jan 2007 02:47:47 +0000
User-Agent: KMail/1.9.5
Cc: Jeff Garzik <jeff@garzik.org>,
       =?utf-8?q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       lwalton@real.com
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <200701191505.33480.s0348365@sms.ed.ac.uk> <45B18160.9020602@shaw.ca>
In-Reply-To: <45B18160.9020602@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701200247.47255.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 January 2007 02:41, Robert Hancock wrote:
> By the way, I assume that you guys are using reiserfs or xfs, as it
> appears no other file systems issue flush commands automatically. I had
> to test this by "echo 1 > delete" on the SCSI disk in sysfs, as I am
> using ext3.

I'll give it a spin now, and yes I'm using several large XFS partitions on 
this machine, layered on top of md RAID5. That's why this particular defect 
is so catastrophic (literally _everything_ is stalled).

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
