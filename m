Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131633AbRCUQjz>; Wed, 21 Mar 2001 11:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131640AbRCUQjp>; Wed, 21 Mar 2001 11:39:45 -0500
Received: from windsormachine.com ([206.48.122.28]:22276 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S131633AbRCUQji>; Wed, 21 Mar 2001 11:39:38 -0500
Message-ID: <3AB8D916.DC7ECC2B@windsormachine.com>
Date: Wed, 21 Mar 2001 11:38:47 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <20010320202020Z130768-406+2207@vger.kernel.org>
		<Pine.LNX.4.10.10103201628390.8689-100000@coffee.psychology.mcmaster.ca>
		<20010321095533Z131410-407+1932@vger.kernel.org> <20010321162530Z131550-406+2504@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

quintaq@yahoo.co.uk wrote:

> I decided to play around a little further.  First, I deleted the "ide0=ata66" from lilo.conf and second I ran bonnie a lot more times.  I found that after the deletion I occasionally (say one time in three or four), saw block reads a little over 30000 KB/sec.  I then tried running bonnie from "/" rather than from a subdirectory.  The result is block reads of better than 30000 KB/sec every time - the record is 37558.  Maybe I should have knowm to run it from root.

Keep in mind that drives have different transfer rates depending on where on the drive you read from.

mike dresser

