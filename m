Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVAJAK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVAJAK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 19:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVAJAKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 19:10:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:6857 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262019AbVAJAIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 19:08:46 -0500
Subject: Re: ERROR: [PATCH] moxa: Update status of Moxa Smartio driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jim Nelson <james4765@cwazy.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <41E0D5B2.7030106@cwazy.co.uk>
References: <200501082329.j08NT873032639@hera.kernel.org>
	 <1105232081.12028.23.camel@localhost.localdomain>
	 <41E0D5B2.7030106@cwazy.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105279392.12054.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 09 Jan 2005 23:04:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-09 at 06:56, Jim Nelson wrote:
> the mxser driver supports the smartio boards - and from the 1.8 mxser package 
> readme.txt:

Read the code 8)

>          (C102H, C102HI, C102HIS, C102P, CP-102, CP-102S)
>          (C114HI, CT-114I, C104P)
>          (C168P)

Note the brackets - they are not supported. I'm not sure what Moxa were
trying to indicate but I have actually pulled all their latest drivers
(and merged mxser). Their last moxa driver is for old old kernels.

Alan

