Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTFXPZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 11:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTFXPZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 11:25:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34739 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262429AbTFXPZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 11:25:43 -0400
Message-ID: <3EF870BC.5010600@pobox.com>
Date: Tue, 24 Jun 2003 11:39:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Subject: Re: Testing IDE-TCQ and Taskfile - doesn't work nicely:)
References: <Pine.SOL.4.30.0306232315480.8078-200000@mion.elka.pw.edu.pl> <3EF86019.3090608@pobox.com> <20030624144730.GW7383@suse.de>
In-Reply-To: <20030624144730.GW7383@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> ide-tcq is even more restrictive now, it only enables TCQ if the drive
> is alone on the channel. Feel free to write the device select code if
> you want, I'm not mucking more with the bastard that is ide tcq.

hehe!  I don't blame you ;-)

I plan to write the devsel code, but for my ata-scsi driver... :/  It 
will go into libata, which I would love to have sharing code with 
drivers/ide...

	Jeff



