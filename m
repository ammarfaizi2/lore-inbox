Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314573AbSDTHT7>; Sat, 20 Apr 2002 03:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314574AbSDTHT6>; Sat, 20 Apr 2002 03:19:58 -0400
Received: from laposte.enst-bretagne.fr ([192.108.115.3]:64523 "EHLO
	laposte.enst-bretagne.fr") by vger.kernel.org with ESMTP
	id <S314573AbSDTHT6>; Sat, 20 Apr 2002 03:19:58 -0400
Message-ID: <3CC116CE.5090505@enst-bretagne.fr>
Date: Sat, 20 Apr 2002 09:20:46 +0200
From: Francois Barre <francois.barre@enst-bretagne.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020412 Debian/0.9.9-6
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, gadio@netvision.net.il
Subject: PROBLEM: buggy ide-scsi
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    ide-scsi not working on kernel 2.5.8

I try to burn cds on a 2.5.8 kernel (debian distrib) using kreatcd (and 
gtoaster) on a Ricoh Ide Cd Writer using the ide-scsi and a unexpected 
error occurs. Using the same config, when I boot on a 2.4.17 kernel, 
there ain't no problem.
Did you change anything ? The ide-scsi module hasn't been maintained 
since Jul 4, 1999 (kinds of 2.2.x period, no ?).
Did configuration change (i tried to turn over, no way...).
In fact, something worrying me. I use the ide-scsi as a module, and 
while no cd burner is launched, lsmod tells me it's used (only in 2.5.8 
kerns, in 2.4.17 it's unused). I wonder if it's not the [scsi_eh_0] 
kernel thread which tries to use it (what for ?). Maybe this is what 
blocks the use of ide-scsi...
I'll try to debug it my way, but it will take ages....

If you have any clues, tell me.

Thanx

F.-E.

