Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbTEKNDT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 09:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbTEKNDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 09:03:19 -0400
Received: from ulima.unil.ch ([130.223.144.143]:13745 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id S261339AbTEKNDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 09:03:15 -0400
Date: Sun, 11 May 2003 15:15:57 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: Jens Axboe <axboe@suse.de>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 and ide-floppy errors
Message-ID: <20030511131557.GA10688@ulima.unil.ch>
References: <20030511124233.GB10013@ulima.unil.ch> <Pine.SOL.4.30.0305111445100.4788-100000@mion.elka.pw.edu.pl> <20030511125243.GK837@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030511125243.GK837@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 02:52:43PM +0200, Jens Axboe wrote:

> Correct, that needs a check. It should work, but is far from optimal
> both from the software and hardware point of view... So I'd much rather
> just keep TCQ enabled only on a single drive on a channel. That way I
> don't have to deal with the ide tcq stupidities.


Well, I don't know if it's better without TCQ:

May 11 15:12:39 localhost kernel: hdb: DMA interrupt recovery
May 11 15:12:39 localhost kernel: hdb: lost interrupt
May 11 15:14:02 localhost kernel: hdb: DMA interrupt recovery
May 11 15:14:02 localhost kernel: hdb: lost interrupt

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
