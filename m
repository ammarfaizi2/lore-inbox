Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUHJKLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUHJKLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUHJKLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:11:38 -0400
Received: from users.linvision.com ([62.58.92.114]:49353 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S264192AbUHJKL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:11:27 -0400
Date: Tue, 10 Aug 2004 12:11:23 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810101123.GB2743@harddisk-recovery.com>
References: <200408061330.i76DU2Tm005937@burner.fokus.fraunhofer.de> <20040806151017.GG23263@suse.de> <20040810084159.GD10361@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810084159.GD10361@merlin.emma.line.org>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 10:41:59AM +0200, Matthias Andree wrote:
> It's not exactly fun if everything can do 48X but your favorite OS
> (Linux 2.4) is limited to say 8X because it only does PIO in spite of
> hdparm settings and everything else.

FWIW, we burn CDs at 40x with a 2.4 kernel. It is however a hardware or
driver related issue: no problems whatsoever with VIA IDE interfaces,
but only PIO with the CD writer connected to a Promise 20268.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
