Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265133AbTF1NTL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 09:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbTF1NTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 09:19:11 -0400
Received: from lns-th2-5f-81-56-227-145.adsl.proxad.net ([81.56.227.145]:6272
	"EHLO blast.mshome.net") by vger.kernel.org with ESMTP
	id S265133AbTF1NTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 09:19:10 -0400
Message-ID: <3EFD9926.5090503@ifrance.com>
Date: Sat, 28 Jun 2003 15:33:26 +0200
From: ced2 <ced2ml@ifrance.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20030627
X-Accept-Language: fr-fr, fr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.4.21] CD-Writer Prolblem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having trouble with my cd-writer :

/dev/hdd:

  Model=Hewlett-Packard CD-Writer Plus 7500, FwRev=1.0a, SerialNo=YMT3WLUJLS
  Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
  RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
  BuffType=unknown, BuffSize=0kB, MaxMultSect=0
  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
  IORDY=on/off, tPIO={min:180,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
  DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2
  AdvancedPM=no

It is recognized with linux 2.4.18 (doesnt work, but recognized), and 
isnt with 2.4.21. My box freeze at its detection.
I've tried ide-scsi, it complains about a timeout, and freeze too.

I'm currently locked to linux 2.4.18, and thats a problem for me 
(pthreads bug, etc..).

Can someone have a tip, an idea, or something ?

