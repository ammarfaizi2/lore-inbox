Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVFMNmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVFMNmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 09:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVFMNmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 09:42:09 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:49880 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261563AbVFMNmA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 09:42:00 -0400
Subject: Re: Odd IDE performance drop 2.4 vs 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Grant Coady <grant_lkml@dodo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42AD6362.1000109@rainbow-software.org>
References: <ac0qa19omlt7bsh8mcfsfr2uhshk338f0c@4ax.com>
	 <42AD6362.1000109@rainbow-software.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1118669975.13260.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Jun 2005 14:39:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-06-13 at 11:43, Ondrej Zary wrote:
> I see this problem too with i430TX chipset (the south bridge and thus 
> IDE controller is the same as in i440LX/EX and BX/ZX).

Make sure you have pre-empt disabled and the antcipatory I/O scheduler
disabled. 

Alan

