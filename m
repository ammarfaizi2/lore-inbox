Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262842AbVEHKdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbVEHKdk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 06:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbVEHKdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 06:33:40 -0400
Received: from web25105.mail.ukl.yahoo.com ([217.12.10.53]:2969 "HELO
	web25105.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262842AbVEHKdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 06:33:38 -0400
Message-ID: <20050508103330.93937.qmail@web25105.mail.ukl.yahoo.com>
Date: Sun, 8 May 2005 12:33:30 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: advices for a lcd driver design.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to write a lcd driver for a HD44780 compatible display.
Basicaly it will be the only screen available on my linux board.
My problem is that I don't know which desgin I should use when
implementing the lcd's driver, because several choices are possible:

1) implementing a dumb char device  "/dev/lcd"
2) implementing a console driver
3) implementing a tty driver

I can't find any documentation on vt that makes the choice quite
hard but when looking at the code it may be the best choice for
user-space. Do you think it's the good direction ?

Thanks for your advices,

      Francis.


	

	
		
__________________________________________________________________ 
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
