Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUGAL2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUGAL2B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 07:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbUGAL2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 07:28:01 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:34309 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264443AbUGAL17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 07:27:59 -0400
Date: Thu, 1 Jul 2004 13:27:55 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Sean Champ <gimbal@sdf.lonestar.org>, Rudo Thomas <rudo@matfyz.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: problems with CF card reader, kernel 2.6.7
Message-ID: <20040701112755.GA6039@pclin040.win.tue.nl>
References: <20040630101605.GA3568@tokamak.homeunix.net> <200406301108.02618.tcfelker@mtco.com> <20040630162054.GA22476@ss1000.ms.mff.cuni.cz> <20040701030411.GA2413@tokamak.homeunix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701030411.GA2413@tokamak.homeunix.net>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: COLLEGEOFNEWCALEDONIA: mailhost.tue.nl 1189; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 08:04:11PM -0700, Sean Champ wrote:

> Jun 30 19:48:56 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
> Jun 30 19:48:56 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)

Not ready - medium not present

> Jun 30 19:49:46 tokamak kernel: usb-storage: -- code: 0x70, key: 0x6, ASC: 0x28, ASCQ: 0x0
> Jun 30 19:49:46 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)

Unit attention - not ready to ready transition

Afterwards things start going wrong, but I wondered about these "unknown" reports.
Probably you have not configured CONFIG_SCSI_CONSTANTS and get only numerical
SCSI error messages.
