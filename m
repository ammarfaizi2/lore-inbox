Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWAWG3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWAWG3R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 01:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWAWG3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 01:29:17 -0500
Received: from relay02.pair.com ([209.68.5.16]:39698 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751405AbWAWG3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 01:29:15 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
Date: Mon, 23 Jan 2006 00:28:50 -0600
User-Agent: KMail/1.9
Cc: Ariel <askernel2615@dsgml.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz> <Pine.LNX.4.62.0601222045180.12815@pureeloreel.qftzy.pbz> <1137997104.2977.7.camel@laptopd505.fenrus.org>
In-Reply-To: <1137997104.2977.7.camel@laptopd505.fenrus.org>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601230029.12674.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2006 00:17, Arjan van de Ven wrote:
> > A commonality I'm noticing is SATA. SATA had a big update in this
> > version, so perhaps that's where to start looking.
>
> I wonder if it can be narrowed even more, like to the exact chipset
> driver?

Anton and I use an Intel 82801 (ICH6). Ariel's dmesg doesn't look like an ICH6 
to me at first glance, but he's also on ata_piix.

Cheers,
Chase
