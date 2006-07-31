Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWGaOM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWGaOM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 10:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWGaOM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 10:12:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50413 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932261AbWGaOM0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 10:12:26 -0400
Subject: Re: Fwd: PROBLEM: ide messages during boot caused by a strange
	partition table
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: marco gaddoni <marco.gaddoni@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3b2bc9d0607310617p21552cc8xba66f935b9ec73bd@mail.gmail.com>
References: <3b2bc9d0607302313p637ce780sf98b1727213bd6a2@mail.gmail.com>
	 <3b2bc9d0607302316s68734797r212e0a422ed26a50@mail.gmail.com>
	 <1154343947.7230.15.camel@localhost.localdomain>
	 <3b2bc9d0607310617p21552cc8xba66f935b9ec73bd@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Jul 2006 15:31:30 +0100
Message-Id: <1154356290.7230.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-31 am 15:17 +0200, ysgrifennodd marco gaddoni:
> is it correct that the max lba sect is LBAsects=156368016 and the kernel
> is asking for 1052835654, 10 times more ?

No you are right - I miscounted the digits in the original report. 

I'm still dubious the partition table is involved unless you've since
booted Windows and the two have been overwriting bits of each other.

What tool created the broken partition table - do you know, and which OS
was installed first ?

