Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUJNOhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUJNOhC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 10:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUJNOeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 10:34:03 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:47599 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S265207AbUJNOdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 10:33:00 -0400
Message-Id: <200410141408.i9EE8BU5013543@ginger.cmf.nrl.navy.mil>
To: Hanna Linder <hannal@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com
Subject: Re: [PATCH 2.6] fore200e.c replace pci_find_device with pci_get_device 
In-Reply-To: Message from Hanna Linder <hannal@us.ibm.com> 
   of "Wed, 13 Oct 2004 15:18:30 PDT." <196790000.1097705910@w-hlinder.beaverton.ibm.com> 
Date: Thu, 14 Oct 2004 10:08:12 -0400
From: "chas williams (contractor)" <chas@cmf.nrl.navy.mil>
X-Spam-Score: (*) hits=1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have to concur.  these need to be fixed the right way.  i can only
test the fore200e changes though.  the other drivers see somewhat
limited use so that is a mistake is made during conversion it isnt
critical.

In message <196790000.1097705910@w-hlinder.beaverton.ibm.com>,Hanna Linder writ
es:
>
>
>As pci_find_device is going away soon I have converted this file to use
>pci_get_device instead. I have compile tested it. If anyone has this ATM card
>and could test it that would be great.
