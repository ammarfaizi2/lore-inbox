Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbTJ3WZX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 17:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbTJ3WZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 17:25:23 -0500
Received: from vic20.blipp.com ([217.75.101.38]:51591 "EHLO vic20.blipp.com")
	by vger.kernel.org with ESMTP id S262865AbTJ3WZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 17:25:19 -0500
Date: Thu, 30 Oct 2003 23:25:18 +0100
From: Patrik Wallstrom <pawal@blipp.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH #2] Re: SATA and 2.6.0-test9
Message-ID: <20031030222518.GL10457@vic20.blipp.com>
References: <20031027141531.GD15558@vic20.blipp.com> <20031027165809.GD19711@gtf.org> <20031027181052.GG32168@vic20.blipp.com> <3FA14F2F.1080700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA14F2F.1080700@pobox.com>
Organization: Foodfight Stockholm
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003, Jeff Garzik wrote:

> >It doesn't hang any more, but the only result is:
> >sata_via version 0.11
> >ata3: SATA max UDMA/133 cmd 0xD800 ctl 0xD402 bmdma 0xC800 irq 16
> >ata4: SATA max UDMA/133 cmd 0xD000 ctl 0xCC02 bmdma 0xC808 irq 16
> >ata3: thread exiting
> >scsi2 : sata_via
> >ata4: thread exiting
> >scsi3 : sata_via
> 
> Actually, attached is a better patch...

Still get the same result as above.

(
patching file drivers/scsi/sata_via.c
Hunk #1 succeeded at 105 (offset -3 lines).
)

Is there any way to know why the thread is exiting?

-- 
patrik_wallstrom->foodfight->pawal@blipp.com->+46-733173956
                `-> http://www.gnuheter.com/
