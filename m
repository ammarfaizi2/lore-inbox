Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTENFxU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 01:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbTENFxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 01:53:19 -0400
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139]:19443 "EHLO
	heavens.murgatroid.com") by vger.kernel.org with ESMTP
	id S261928AbTENFxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 01:53:17 -0400
From: "Christopher Hoover" <ch@murgatroid.com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: RE: [PATCH] 2.5.68: Don't include SCSI block ioctls on non-scsi systems
Date: Tue, 13 May 2003 23:05:55 -0700
Organization: Murgatroid.Com
Message-ID: <000501c319de$e20aab50$7900000a@bergamot>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20030514065752.A647@infradead.org>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Unless I'm missing something, there doesn't seem to be a good reason
> > for the block system to include SCSI ioctls unless there's a SCSI
> > block device (CONFIG_BLK_DEV_SD) in the system.
> 
> That's broken.  You can use them on ide, sd and sr currently.

Thanks for the G-2.  I'll revise the patch ...

-ch

