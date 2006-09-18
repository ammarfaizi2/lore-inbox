Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWIRJTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWIRJTH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 05:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965603AbWIRJTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 05:19:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:65479 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751550AbWIRJTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 05:19:03 -0400
Subject: Re: kmalloc to kzalloc patches for drivers/atm
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Om Narasimhan <om.turyx@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       linux-atm-general@lists.sourceforge.net
In-Reply-To: <6b4e42d10609171753i63697c8et3e6e1c5706b60d5f@mail.gmail.com>
References: <6b4e42d10609171753i63697c8et3e6e1c5706b60d5f@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Sep 2006 10:42:47 +0100
Message-Id: <1158572567.6069.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-09-17 am 17:53 -0700, ysgrifennodd Om Narasimhan:
> Tested by compiling.
> 
> I have not subscribed to ATM list. Please cc me any comments.
> 


NAK - again changes some that don't need to clear the memory they
allocate

