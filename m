Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTJTKqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 06:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbTJTKqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 06:46:44 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:47010 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262529AbTJTKqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 06:46:42 -0400
Date: Mon, 20 Oct 2003 12:44:33 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Torben Mathiasen <torben.mathiasen@hp.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] fix ServerWorks PIO auto-tuning
Message-ID: <20031020104433.GB28755@louise.pinerecords.com>
References: <200310162344.09021.bzolnier@elka.pw.edu.pl> <20031018130234.GA28095@louise.pinerecords.com> <200310181745.41768.bzolnier@elka.pw.edu.pl> <20031020092445.GB1685@tmathiasen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031020092445.GB1685@tmathiasen>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct-20 2003, Mon, 11:24 +0200
Torben Mathiasen <torben.mathiasen@hp.com> wrote:

> BTW Tomas, that drive you're adding to your ML350G2, is that just to have
> a spare IDE disk drive? IIRC, the 350 is a SCSI system with only an ATAPI
> cdrom drive. But I could be wrong.

Yes, Torben, you are corrent, the IDE drive is just a spare
used for doing nightly backups of the SCSI system partitions.
We've been using 80GB/120GB WD drives in many OSB4/CSB5-based
HP/Compaq systems (mostly this Proliant model, HP E800 and HP
TC3100) with hand-enabled DMA and have so far had no problems.

(Btw, this particular ML350G3 came with an add-on cciss hwraid
card that seemed to exhibit extremely poor performance, so we
attached all the SCSI drives directly to the onboard AIC7xxx
and went for /dev/md*.)

Thanks,
-- 
Tomas Szepe <szepe@pinerecords.com>
