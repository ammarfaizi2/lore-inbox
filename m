Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVEBQdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVEBQdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVEBQaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:30:35 -0400
Received: from lantana.tenet.res.in ([202.144.28.166]:36523 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261447AbVEBQ31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:29:27 -0400
Date: Mon, 2 May 2005 21:59:59 +0530 (IST)
From: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: stuffing characters to keyboard buffer.
Message-ID: <Pine.LNX.4.60.0505022126520.5301@lantana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hai,
       I want to stuff the characters received on a serial line into the 
keyboard buffer, so that they will be send to applications as if they are 
coming from keyboard irrespective of console or x-windows mode.

       For this purpose, I planned to use ioctls. Can anybody tell how to 
send an ioctl to keyboard driver?

       AFAIK, tty_flip_buffer is the buffer from which both console and 
x-windows will take input. If we insert into this buffer, I think the 
purpose will be served. Now the question is how to send ioctl to this 
buffer.
   can you please give any suggestions on this?



   Thanks&Regards,
   P.Manohar,

