Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753178AbWKHVjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbWKHVjn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753523AbWKHVjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:39:43 -0500
Received: from [81.2.110.250] ([81.2.110.250]:7853 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1753178AbWKHVjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:39:42 -0500
Subject: Re: IDE cs5530 hda: lost interrupt
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Saulo <slima@tse.gov.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <455254B8.4000704@tse.gov.br>
References: <455254B8.4000704@tse.gov.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Nov 2006 21:44:23 +0000
Message-Id: <1163022263.23956.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-11-08 am 19:05 -0300, ysgrifennodd Saulo:
> 14:          2    XT-PIC  ide0    >>> just 2 interrupts
> 15:       2964    XT-PIC  ide1
> NMI:         0
> ERR:         0

Thats very odd indeed as the IRQ is hard wired to 14. Are you sure the
system works with other OS's and isn't faulty (I ask this as its the
first 5530 report of this kind I've seen in about ten years, and the
device is in legacy mode which means its hard wired to IRQ 14)

Alan

