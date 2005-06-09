Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVFIJ7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVFIJ7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 05:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVFIJ7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 05:59:31 -0400
Received: from web25803.mail.ukl.yahoo.com ([217.12.10.188]:48209 "HELO
	web25803.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261532AbVFIJ71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 05:59:27 -0400
Message-ID: <20050609095927.59628.qmail@web25803.mail.ukl.yahoo.com>
Date: Thu, 9 Jun 2005 11:59:26 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: [TTY] exclusive mode question
To: Frederik Deweerdt <dev.deweerdt@laposte.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050609093642.GA507@gilgamesh.home.res>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Frederik Deweerdt <dev.deweerdt@laposte.net> a écrit :

> I've just greped and I found :
> 
> if (!retval && test_bit(TTY_EXCLUSIVE, &tty->flags) &&
> !capable(CAP_SYS_ADMIN))
> 	retval = -EBUSY;
> in drivers/char/tty_io.c:tty_open
> 
> Which sources are you looking at?
> 

same source code but if another process has previously open the tty, how does
this source code detect it ?

             Francis


	
	
		
_____________________________________________________________________________ 
Découvrez le nouveau Yahoo! Mail : 1 Go d'espace de stockage pour vos mails, photos et vidéos ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
