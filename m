Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264614AbUDVT2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264614AbUDVT2U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 15:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbUDVT2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 15:28:20 -0400
Received: from smtp-out9.xs4all.nl ([194.109.24.10]:20748 "EHLO
	smtp-out3.xs4all.nl") by vger.kernel.org with ESMTP id S264614AbUDVT2S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 15:28:18 -0400
Date: Thu, 22 Apr 2004 21:28:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv.local
To: James Bottomley <James.Bottomley@steeleye.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, <kieran@ihateaol.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Why is CONFIG_SCSI_QLA2X_X always enabled?
In-Reply-To: <1082660161.1778.100.camel@mulgrave>
Message-ID: <Pine.LNX.4.44.0404222127180.766-100000@serv.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22 Apr 2004, James Bottomley wrote:

> On Thu, 2004-04-22 at 14:37, Randy.Dunlap wrote:
> > which isn't a problem by itself, as you suggest (maybe?).
>
> Yes, it was a harmless evolutionary addition to save having a depends
> SCSI && PCI on every config option in the qla2xxx/Kconfig.

Use "if SCSI && PCI" ... "endif" instead.

bye, Roman

