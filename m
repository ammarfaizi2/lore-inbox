Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263843AbUDZOMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbUDZOMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 10:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbUDZOE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 10:04:57 -0400
Received: from users.linvision.com ([62.58.92.114]:48046 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263979AbUDZNvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 09:51:01 -0400
Date: Mon, 26 Apr 2004 15:50:58 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: andersen@codepoet.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] prevent module unloading for legacy IDE chipset drivers
Message-ID: <20040426135058.GC14074@harddisk-recovery.com>
References: <200404212219.24622.bzolnier@elka.pw.edu.pl> <200404220250.15078.bzolnier@elka.pw.edu.pl> <20040422103355.GC15176@harddisk-recovery.com> <200404221635.12490.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404221635.12490.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 04:35:12PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 22 of April 2004 12:33, Erik Mouw wrote:
> > What makes IDE sufficiently different from SCSI that we can't unload
> > IDE host drivers?
> 
> - no reference counting
> - lack of release() method
> - insufficient locking

Do you plan to fix the module unloading in the current code, or is it
easier to write a new driver based on libata (assuming it has been
fixed in libata)? If I understood Jeff's latest libata update
correctly, it should be possible Real Soon Now [tm], right?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
