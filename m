Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131550AbRCUQZn>; Wed, 21 Mar 2001 11:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131585AbRCUQZd>; Wed, 21 Mar 2001 11:25:33 -0500
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:27410 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131550AbRCUQZ3>; Wed, 21 Mar 2001 11:25:29 -0500
X-Apparently-From: <quintaq@yahoo.co.uk>
Date: Wed, 21 Mar 2001 16:26:58 +0000
From: quintaq@yahoo.co.uk
To: <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <20010321095533Z131410-407+1932@vger.kernel.org>
In-Reply-To: <20010320202020Z130768-406+2207@vger.kernel.org>
	<Pine.LNX.4.10.10103201628390.8689-100000@coffee.psychology.mcmaster.ca>
	<20010321095533Z131410-407+1932@vger.kernel.org>
Reply-To: <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 0.4.62 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20010321162530Z131550-406+2504@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001 09:56:56 +0000
quintaq@yahoo.co.uk wrote:

> am I correct in interpreting the bonnie output for
> the block read (included in my earlier post), of 20937 KB/sec as
> reasonably healthy for my DTLA (ie consistent with hdparm's 30 MB/sec),
> when performing more realistic tasks on the linux filesystem ?
> 
I decided to play around a little further.  First, I deleted the "ide0=ata66" from lilo.conf and second I ran bonnie a lot more times.  I found that after the deletion I occasionally (say one time in three or four), saw block reads a little over 30000 KB/sec.  I then tried running bonnie from "/" rather than from a subdirectory.  The result is block reads of better than 30000 KB/sec every time - the record is 37558.  Maybe I should have knowm to run it from root.

Regards,

Geoff

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

