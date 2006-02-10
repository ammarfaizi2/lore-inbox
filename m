Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWBJOLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWBJOLc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWBJOLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:11:32 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:50686 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932091AbWBJOLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:11:31 -0500
Date: Fri, 10 Feb 2006 15:11:30 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Imre Gergely <imre.gergely@astral.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: disabling libata
Message-ID: <20060210141130.GE28676@harddisk-recovery.com>
References: <43EC97C6.10607@astral.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EC97C6.10607@astral.ro>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 03:40:22PM +0200, Imre Gergely wrote:
> i have a SATA hardisk, and am using FC4 with default kernel
> (2.6.14-1.1644_FC4). i was wondering if it's possible to tell the kernel to use
> the old ATA driver with SATA support instead of libata, for my harddisk to
> appear as hdX, and not sdX.

Why would you want to do that? SATA are driven by libata and the disks
turn up as SCSI devices. There's no way around that (yet).


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
