Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268203AbUHTPWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268203AbUHTPWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268183AbUHTPWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:22:13 -0400
Received: from 34.67-18-129.reverse.theplanet.com ([67.18.129.34]:12704 "EHLO
	krish.dnshostnetwork.net") by vger.kernel.org with ESMTP
	id S268236AbUHTPVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:21:38 -0400
Message-ID: <000901c486c9$40d92e60$6d59023d@dreammachine>
From: "Pankaj Agarwal" <pankaj@pnpexports.com>
To: "Andreas Schwab" <schwab@suse.de>
Cc: <linux-kernel@vger.kernel.org>
References: <001901c485cc$208c3a60$9159023d@dreammachine> <je657fzchp.fsf@sykes.suse.de>
Subject: Re: how to identify filesystem type
Date: Thu, 19 Aug 2004 19:33:22 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - krish.dnshostnetwork.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - pnpexports.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

this is the output when you have a mounted block device.....you can only
mount when you know the filesystem ....thats wat i wanna know...hoe to
identify filesytems...on ablockdevice.

thanks anyways, looking forward for more information on this

Pankaj


----- Original Message -----
From: "Andreas Schwab" <schwab@suse.de>
To: "Pankaj Agarwal" <pankaj@pnpexports.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, August 19, 2004 3:16 PM
Subject: Re: how to identify filesystem type


"Pankaj Agarwal" <pankaj@pnpexports.com> writes:

> I need your help, in understanding filesystems. Kindly let me know how to
> identify the filesystem in an image file or block device.

Use file:

# file -s /dev/hda3
/dev/hda3: ReiserFS V3.6 block size 4096 (mounted or unclean) num blocks
9500285 r5 hash

Andreas.

--
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



