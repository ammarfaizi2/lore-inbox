Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131652AbRAHRJR>; Mon, 8 Jan 2001 12:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131388AbRAHRJI>; Mon, 8 Jan 2001 12:09:08 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6150 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129736AbRAHRIx>; Mon, 8 Jan 2001 12:08:53 -0500
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
To: stefan@hello-penguin.com
Date: Mon, 8 Jan 2001 17:10:11 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), viro@math.psu.edu (Alexander Viro),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010108172225.A1391@stefan.sime.com> from "Stefan Traby" at Jan 08, 2001 05:22:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FfoD-0004wW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I reread SuSv2 again and didn't found corner cases.
> Do you mean FIFO/pipe stuff ? I can't see the problem in this area.
> 
> In which case is an emulation of pathconf by fpathconf impossible ?

use all your file descriptors up. Now try

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
