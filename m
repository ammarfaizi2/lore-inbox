Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316954AbSEWQiU>; Thu, 23 May 2002 12:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316955AbSEWQiT>; Thu, 23 May 2002 12:38:19 -0400
Received: from line103-203.adsl.actcom.co.il ([192.117.103.203]:38661 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S316954AbSEWQiR>; Thu, 23 May 2002 12:38:17 -0400
Date: Thu, 23 May 2002 19:35:02 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: linux-kernel@vger.kernel.org
Subject: ppp_deflate.o taints the kernel?
Message-ID: <20020523193502.H15025@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salutations, 

The ppp_deflate.o module has the license string "BSD without
advertisement clause". Loading this module appears to taint the
kernel, which agrees with the allowed licenses list in
include/module.h, and with list in latest modutils (2.4.16),
obj/obj_gpl_license, where this license string does not appear.

I plead an utter lack of clue in regards to licenses, but assume that
it's GPL compatible if it's distributed with the kernel. In that case,
shouldn't it be added to the license list?

Thanks, 
-- 
Monday 1 Forelithe 7466

http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/
