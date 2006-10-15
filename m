Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161195AbWJOWfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbWJOWfW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 18:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbWJOWfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 18:35:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:26603 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161195AbWJOWfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 18:35:21 -0400
Subject: Re: privilege levels and kernel mode
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061015191716.15283.qmail@web27401.mail.ukl.yahoo.com>
References: <20061015191716.15283.qmail@web27401.mail.ukl.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 00:02:09 +0100
Message-Id: <1160953329.5732.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-10-15 am 20:17 +0100, ysgrifennodd ranjith kumar:
> I know how to include assembly instructions in a C
> program to wtrite into "Model specific registers". But
> that program has to be run at privilege level zero.

Its more hairy than that because of SMP and handling overflows and
according to whether you need to profile all use or your own task and so
on. Fortunately someone has done all the hard work already - take a look
at the oprofile support in the kernel and see if it will do what you
need.

Alan
