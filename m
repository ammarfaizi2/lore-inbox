Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbUDZGbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUDZGbn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 02:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbUDZGbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 02:31:43 -0400
Received: from users.linvision.com ([62.58.92.114]:51350 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263095AbUDZGbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 02:31:40 -0400
Date: Mon, 26 Apr 2004 08:31:37 +0200
From: Rogier Wolff <R.E.Wolff@Harddisk-recovery.com>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       andersen@codepoet.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] prevent module unloading for legacy IDE chipset drivers
Message-ID: <20040426063137.GB11567@bitwizard.nl>
References: <200404212219.24622.bzolnier@elka.pw.edu.pl> <20040422004104.GA19969@codepoet.org> <200404220250.15078.bzolnier@elka.pw.edu.pl> <20040422103355.GC15176@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040422103355.GC15176@harddisk-recovery.com>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 12:33:55PM +0200, Erik Mouw wrote:
> On Thu, Apr 22, 2004 at 02:50:15AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 22 of April 2004 02:41, Erik Andersen wrote:
> > > Out of curiosity, what would be needed to make it safe to unload
> > > all ide modules from a system with a scsi rootfs?
> > 
> > It doesn't matter - you still may end up unloading modules which are in use.
> 
> FWIW, with the old IDE code I've been unloading IDE modules for years
> without a single problem.

Hmm. Not completely true: It crashes on our VIA EPIA board. Would 
anybody have an idea why it works on most systems, but crashes
hard on the VIA EPIA? (I'm not sure wether it crashes the hardware
or the software). 

			Roger. 

-- 
+-- Rogier Wolff -- www.harddisk-recovery.nl -- 0800 220 20 20 --
| Files foetsie, bestanden kwijt, alle data weg?!
| Blijf kalm en neem contact op met Harddisk-recovery.nl!
