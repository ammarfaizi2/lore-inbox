Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263919AbUDVKeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263919AbUDVKeA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 06:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263924AbUDVKeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 06:34:00 -0400
Received: from users.linvision.com ([62.58.92.114]:58582 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263919AbUDVKd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 06:33:57 -0400
Date: Thu, 22 Apr 2004 12:33:55 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: andersen@codepoet.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] prevent module unloading for legacy IDE chipset drivers
Message-ID: <20040422103355.GC15176@harddisk-recovery.com>
References: <200404212219.24622.bzolnier@elka.pw.edu.pl> <20040422004104.GA19969@codepoet.org> <200404220250.15078.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404220250.15078.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 02:50:15AM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 22 of April 2004 02:41, Erik Andersen wrote:
> > Out of curiosity, what would be needed to make it safe to unload
> > all ide modules from a system with a scsi rootfs?
> 
> It doesn't matter - you still may end up unloading modules which are in use.

FWIW, with the old IDE code I've been unloading IDE modules for years
without a single problem.

What makes IDE sufficiently different from SCSI that we can't unload
IDE host drivers?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
