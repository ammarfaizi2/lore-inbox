Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289639AbSBEQVL>; Tue, 5 Feb 2002 11:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289643AbSBEQVC>; Tue, 5 Feb 2002 11:21:02 -0500
Received: from relay03.cablecom.net ([62.2.33.103]:27161 "EHLO
	relay03.cablecom.net") by vger.kernel.org with ESMTP
	id <S289639AbSBEQUq>; Tue, 5 Feb 2002 11:20:46 -0500
Message-Id: <200202051620.g15GKdH17123@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: lord latex <llx@swissonline.ch>
Reply-To: llx@swissonline.ch
To: linux-kernel@vger.kernel.org
Subject: confused about block device behaviour
Date: Tue, 5 Feb 2002 17:19:11 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

i've got written a block device driver for the 2.4.x 
kernel and it seems to work. but something looks 
strange to me. i've go a very simple application that 
does nothing more then open the block device, read 
1024 byte and close the device. when i run this app. 
serveral times my do_request function gets called 
every time. why? i expect this block beeing buffered 
in the buffer cache. what do i don't see, or what is 
possibly wrong with my block device?

thanks
