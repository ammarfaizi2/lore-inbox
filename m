Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSLEOmc>; Thu, 5 Dec 2002 09:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbSLEOmc>; Thu, 5 Dec 2002 09:42:32 -0500
Received: from 24-216-100-96.charter.com ([24.216.100.96]:52664 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S261318AbSLEOmb>;
	Thu, 5 Dec 2002 09:42:31 -0500
Date: Thu, 5 Dec 2002 09:50:00 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: eth1 blowing up?
Message-ID: <20021205145000.GF32203@rdlg.net>
Mail-Followup-To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I just started getting this:

eth1: transmit timed out, tx_status 00 status e000.     
  diagnostics: net 0cd8 media 8880 dma 000000a0.   
  Flags; bus-master 1, dirty 212(4) current 228(4)
  Transmit list 1fe27300 vs. dfe27300.            
  0: @dfe27200  length 8000002a status 0000002a
  1: @dfe27240  length 8000002a status 0000002a
  2: @dfe27280  length 8000002a status 8000002a
  3: @dfe272c0  length 8000002a status 8000002a
  4: @dfe27300  length 020207e1 status 01f20000
  5: @dfe27340  length 8000002a status 0000002a
  6: @dfe27380  length 8000002a status 0000002a
  7: @dfe273c0  length 8000002a status 0000002a
  8: @dfe27400  length 8000002a status 0000002a
  9: @dfe27440  length 8000002a status 0000002a
  10: @dfe27480  length 8000002a status 0000002a
  11: @dfe274c0  length 8000002a status 0000002a
  12: @dfe27500  length 8000002a status 0000002a
  13: @dfe27540  length 8000002a status 0000002a
  14: @dfe27580  length 8000002a status 0000002a
  15: @dfe275c0  length 8000002a status 0000002a
                                                

Is my eth1 dying or is someone sending something dirty?  I've never seen
this one before.

kernel 2.4.19-ac4 eth1 is a 3c905 I believe.


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: FC96D405
                               
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'

