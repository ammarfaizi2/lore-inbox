Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263683AbTICQD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTICQDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:03:19 -0400
Received: from mail.wp-sa.pl ([212.77.102.105]:14272 "EHLO mail.wp-sa.pl")
	by vger.kernel.org with ESMTP id S263683AbTICQCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:02:32 -0400
Date: Wed, 03 Sep 2003 18:02:29 +0200
From: Mariusz Zielinski <levi@wp-sa.pl>
Subject: Re: Driver Model
In-reply-to: <004801c37233$08c93b10$294b82ce@stuartm>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Message-id: <200309031802.29930.levi@wp-sa.pl>
Organization: Wirtualna Polska S.A.
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.9
References: <004801c37233$08c93b10$294b82ce@stuartm>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 of September 2003 17:50, Stuart MacDonald wrote:
> From: Mariusz Zielinski [mailto:levi@wp-sa.pl]
>
> > Realtek 8180L wlan chipset driver.
>
> From:
> http://www.realtek.com.tw/downloads/downloads1-3.aspx?series=16&Software=Tr
>ue
>
> These drivers are all source and appear to be all GPLed.

Look at
http://www.realtek.com.tw/downloads/downloads1-3.aspx?lineid=2002111&famid=2002111&series=2002121&Software=True

Archive:  rh90-8180(120).zip
 Length   Method    Size  Ratio   Date   Time   CRC-32    Name
--------  ------  ------- -----   ----   ----   ------    ----
    2150  Defl:N      769  64%  07-24-03 10:30  bdcbb2db  release/Makefile
  216130  Defl:N    84093  61%  07-24-03 10:30  f6e934c9  release/priv_part.o
                                                          ^^^^^^^^^^^^^^^^^^^
    1503  Defl:N      548  64%  07-24-03 10:30  aa55c41c  release/r8180_export.h
   17834  Defl:N     3524  80%  07-24-03 10:30  b00831ae  release/r8180_if.c
    4488  Defl:N     1278  72%  07-24-03 10:30  00e6785f  release/r8180_if.h
   13319  Defl:N     2811  79%  07-24-03 10:30  1ad0ac11  release/r8180_pci_init.c
                                                          ^^^^^^^^^^^^^^^^^^^^^^^^
#cat r8180_pci_init.c | grep MODULE_LICENSE
MODULE_LICENSE("GPL");

     528  Defl:N      321  39%  07-24-03 10:30  9fe4dafc  release/r8180_pci_init.h
    8722  Defl:N     2028  77%  07-24-03 10:30  580d8c16  release/r8180_type.h
    5072  Defl:N     1709  66%  07-24-03 10:30  90348255  release/readme
     529  Defl:N      320  40%  07-24-03 10:30  aafe3723  release/rls_note_0724
     155  Defl:N      116  25%  07-24-03 10:30  6d3018fc  release/wlandown
     587  Defl:N      266  55%  07-24-03 10:30  763d2e5f  release/wlanup
--------          -------  ---                            -------
  271017            97783  64%                            12 files

-- 
Mariusz Zielinski
