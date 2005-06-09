Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVFIItM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVFIItM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 04:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVFIItM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 04:49:12 -0400
Received: from web25805.mail.ukl.yahoo.com ([217.12.10.190]:3935 "HELO
	web25805.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262286AbVFIItJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 04:49:09 -0400
Message-ID: <20050609084908.82923.qmail@web25805.mail.ukl.yahoo.com>
Date: Thu, 9 Jun 2005 10:49:07 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: [TTY] exclusive mode question
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

When a process open a tty in exclusive mode (using ioctl(X, TIOCEXCL)), can the
process be sure to be the only one using this tty ?
If so I can't find in kernel code any checks in "tty_open" method for verifying
that the tty has not been opened previously by another process when
"TTY_EXCLUSIVE" flag is set.

Thanks

           Francis


	

	
		
_____________________________________________________________________________ 
Découvrez le nouveau Yahoo! Mail : 1 Go d'espace de stockage pour vos mails, photos et vidéos ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com
