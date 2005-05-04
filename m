Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVEDIql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVEDIql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 04:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVEDIql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 04:46:41 -0400
Received: from lantana.tenet.res.in ([202.144.28.166]:47295 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261496AbVEDIqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 04:46:39 -0400
Date: Wed, 4 May 2005 14:17:13 +0530 (IST)
From: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: Re: stuffing characters to keyboard buffer.
In-Reply-To: <200505021152.19778.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.60.0505041409150.12570@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0505022126520.5301@lantana.cs.iitm.ernet.in>
 <200505021152.19778.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am working in 
2.4.20-8 kernel.
To fill the keyboard buffer  with characters from user space, I used 
TIOCSTI
ioctls. Is there a similar method so I can send raw keyboard codes into
the scancode buffer? 
ioctls("/dev/tty0",TIOCSTI,&c);
    it worked in Console.

ioctls("/dev/tty7",TIOCSTI,&c);
   is not working in x-windows. Here c is a character.

Can you guide me in this regard.

  ThanksInAdvance,
   P.Manohar,

