Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272336AbTHIMTY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 08:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272339AbTHIMTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 08:19:24 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:64413 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S272336AbTHIMTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 08:19:23 -0400
Message-ID: <3F34E6D1.7030900@sbcglobal.net>
Date: Sat, 09 Aug 2003 07:19:29 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: reiserfs-list@namesys.com
Subject: Re: FS Corruption with VIA MVP3 + UDMA/DMA
References: <16128.19218.139117.293393@charged.uio.no> <3F007EBF.9020506@sbcglobal.net> <3F10729F.7070701@sbcglobal.net>
In-Reply-To: <3F10729F.7070701@sbcglobal.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seemed to get a skeptical reaction when I originally posted this to 
the list, however, just google for "mvp3 corrupt dma mode" to confirm.  
I don't know that it takes to hit this error, but it's very easy to 
reproduce on my machine.  Some links only mention UDMA, but all DMA 
modes are affected on my board.  I couldn't even burn a CD over 12X 
without running into this issue.  There I thought it was bad media, but 
after burning 11 CD's at 32X with the PDC20269 (rather than the native 
IDE) and not encountering any errors using the same batch of media and 
writer, the culprit is clear.

I don't know why I didn't google for this in the first place, but it 
looks like it is a known issue.  Just apparently not well-known.

Probably not especially important though, I wonder just how many people 
are still running this setup...  With Linux, I'd say even fewer.





