Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUHJNCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUHJNCE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUHJM7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:59:00 -0400
Received: from [213.146.154.40] ([213.146.154.40]:26853 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265119AbUHJM5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:57:43 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: David Woodhouse <dwmw2@infradead.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       eric@lammerts.org, linux-kernel@vger.kernel.org
In-Reply-To: <200408101247.i7AClub5014046@burner.fokus.fraunhofer.de>
References: <200408101247.i7AClub5014046@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Message-Id: <1092142656.4383.8155.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 10 Aug 2004 13:57:37 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 14:47 +0200, Joerg Schilling wrote:
> Cdrecord does not read /etc/cdrecord.conf

And the world is flat.

shinybook /home/dwmw2 $ strace -e open cdrecord -inq 2>&1 | grep /etc/cdrecord.conf
open("/etc/cdrecord.conf", O_RDONLY)    = 3
open("/etc/cdrecord.conf", O_RDONLY)    = 3
open("/etc/cdrecord.conf", O_RDONLY)    = 3
open("/etc/cdrecord.conf", O_RDONLY)    = 3

> Jrg

-- 
dwmw2

