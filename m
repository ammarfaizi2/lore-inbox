Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283316AbRK2QhA>; Thu, 29 Nov 2001 11:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283314AbRK2Qgl>; Thu, 29 Nov 2001 11:36:41 -0500
Received: from tomts11.bellnexxia.net ([209.226.175.55]:32252 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S283313AbRK2QgY>; Thu, 29 Nov 2001 11:36:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nav Mundi <nmundi@karthika.com>
Date: Thu, 29 Nov 2001 11:36:14 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Subject: Kernal <-> Block Driver <-> Storage Device
Message-Id: <20011129163618.EMQJ24249.tomts11-srv.bellnexxia.net@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scenario:
1) Interupt requests from Kernal to read information.
2) Kernel asks block driver to fetch some information from the storage device
3) The block driver fetchs this information and stores it in the DMA
4) The storage device then interupts the Kernal OR Driver to signal that it 
is finished reading. 

Questions:
1) In step 4), does the storage device interupt the Kernal or the Driver when 
it is finished reading information to the DMA?  
2) If the Kernal is interrupted what does the Kernel do then?  
3) If the Block Driver is interrupted, what does the Driver do then?
4) Where is the code located for Questions 1) -> 3)

Please advise. Thanks.
-Nav





