Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbULLNe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbULLNe6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 08:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbULLNe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 08:34:58 -0500
Received: from 82-43-72-5.cable.ubr06.croy.blueyonder.co.uk ([82.43.72.5]:16889
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S262067AbULLNez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 08:34:55 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ide-cd problem revisited - more brainpower needed
Date: Sun, 12 Dec 2004 13:34:55 +0000
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
References: <200411201842.15091.alan@chandlerfamily.org.uk> <200412120017.22249.alan@chandlerfamily.org.uk> <1102851547.1371.17.camel@localhost.localdomain>
In-Reply-To: <1102851547.1371.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412121334.55460.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 December 2004 11:39, Alan Cox wrote:

> Thanks ok so it moves with the drive. I'm beginning to wonder if it is
> just a dud drive.

I do too and am almost ready to throw in the towel (and I seem to be almost 
unique in experiencing these problems) - except

1) There is an open bug report on debian (#265747) of someone with the same 
model of drive having problems (and to which I added myself).  Later down the 
bug discussion someone else has chipped in with a Cyberdrive (different 
model) with problems.



3) This is absolutely consistent every run.  Its the READ BUFFER command where 
it first occurs (without DMA), and this is not the first time that data has 
been transfered (via pio).  However, under both Windows XP and linux 2.4 
(using the ide-scsi module) the drive works perfectly.

[Thinks - maybe I should spend some time looking at the 2.4 code and 
understanding the differences]

Yesterday, I eventually got to the Cyberdrive Web site (it seems to have been 
unavailable for a while) and downloaded the latest firmware upgrade.  The 
upgrade worked perfectly (had to do it under windows) and it made absolutely 
no difference.




-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi
