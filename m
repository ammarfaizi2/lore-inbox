Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbTHTPhr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 11:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbTHTPhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 11:37:47 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:6812
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S262005AbTHTPhq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 11:37:46 -0400
Date: Wed, 20 Aug 2003 11:47:19 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Christian Axelsson <smiler@lanil.mine.nu>
Cc: "Bryan D. Stine" <admin@kentonet.net>, linux-kernel@vger.kernel.org
Subject: Re: DVD ROM on 2.6
Message-ID: <20030820114719.A26833@animx.eu.org>
References: <20030819193456.B25148@animx.eu.org> <200308192003.22182.admin@kentonet.net> <20030819202108.A25325@animx.eu.org> <3F437D8A.3040409@lanil.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3F437D8A.3040409@lanil.mine.nu>; from Christian Axelsson on Wed, Aug 20, 2003 at 03:54:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >I do have DVDs playing now on 2.6.0-test3.  I used ide-cd instead of
> >ide-scsi.  apparently the scsi layer didn't like it.
> >Buffer I/O error on device sr1, logical block 7651
> >Buffer I/O error on device sr1, logical block 7652
> >Buffer I/O error on device sr1, logical block 7653
> >end_request: I/O error, dev sr1, sector 660400
> >
> >I would get tons of Buffer I/O errors and some end_requests like the above
> >
> I thought ide-scsi was broken?

I can't tell if this is in the ide-scsi driver or the scsi cdrom driver.  I
still personally wish that the ide drivers were modules of scsi instead of
being a seperate block device.  USB storage creates scsi adapters, ide-scsi
allows ATAPI access via scsi.  Why not do this for ide in general (if that
starts a flame war, please don't contribute =)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
