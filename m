Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289320AbSAIKYu>; Wed, 9 Jan 2002 05:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289319AbSAIKYk>; Wed, 9 Jan 2002 05:24:40 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:4356 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S289318AbSAIKY2>; Wed, 9 Jan 2002 05:24:28 -0500
Message-ID: <3C3C1A54.62DBF079@aitel.hist.no>
Date: Wed, 09 Jan 2002 11:24:20 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.2-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: fs corruption recovery?
In-Reply-To: <3C3BB082.8020204@fit.edu>
		<20020108200705.S769@lynx.adilger.int> <200201090326.g093QBF27608@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Andreas Dilger writes:
[...]
> > Is the data really that valuable, and you don't have a backup?  It may
> > cost you several thousand dollars to do a recovery from such a company.
> > Yet, it isn't worth doing backups, it appears.
> 
> And these companies don't really do much that you can't do yourself. I
> had a failing drive some years ago, where some sectors couldn't be
> read. So I tried to dd the raw device to a file elsewhere. Of course,
> dd will quit when it has an I/O error. So I wrote a recovery utility
> that writes a zero sector if reading the input sector gives an I/O
> error. Unfortunately, I couldn't mount the file (too much corruption),
> but I was able to use debugfs on it. I got the most important data
> back.
> 
> While I was waiting for 48 hours for the data to be pulled off (each
> time a bad sector was encountered, the drive would retry several
> times, with lots of clicking and rattling), I contacted one of these
> recovery companies. I wanted to know if they could recover the bad
> sectors. I was told no. After some probing, it turns out that all they
> do is basically what I was doing. They just charge $2000 for it.
> 
> No doubt if you took your drive to your local CIA/KGB/MI6 offices,
> they could recover some of those bad sectors. But I hear they charge
> their customers quite a lot...

No need for CIA/KGB.  There are companies that do more than this.  
If necessary, they disassemble the drive in a clean room and use 
their own reading equipment.  This allows recovery
from fried drive electronics and broken motors/heads.  And sometimes
(partial) recovery from scratches and other bad sectors.

If you really need this, consider
http://www.ibasuk.com/technology/patan.htm

Helge Hafting
