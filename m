Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbTLQPJl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 10:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbTLQPJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 10:09:41 -0500
Received: from needs-no.brain.uni-freiburg.de ([132.230.63.23]:37656 "EHLO
	needs-no.brain.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S264422AbTLQPJk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 10:09:40 -0500
Date: Wed, 17 Dec 2003 16:09:33 +0100 (MET)
From: Thomas Voegtle <thomas@voegtle-clan.de>
To: linux-kernel@vger.kernel.org
Subject: no atapi cdrecord burning with 2.6.0-test11-bk10 / bk13
Message-ID: <Pine.LNX.4.21.0312171604390.32339-100000@needs-no.brain.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
  
cdrecord -dev=ATAPI -scanbus  with 2.6.0-test11-bk10 and bk13 shows this:
  
scsibus0:
        0,0,0     0) '' '' '' NON CCS Disk
        0,1,0     1) '' '' '' NON CCS Disk

  
but this works well with 2.6.0-test11.
=>
  
        0,0,0     0) 'CREATIVE' ' CD5233E        ' '2.05' Removable CD-ROM
        0,1,0     1) 'PLEXTOR ' 'CD-R   PX-W1610A' '1.04' Removable CD-ROM
  
SuSE 9.0
  
please cc me, I'm not subscribed
  
Greetings
Thomas



-- 
 Thomas Vögtle    email: thomas@voegtle-clan.de
 ----- http://www.voegtle-clan.de/thomas ------


