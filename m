Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277849AbRJWQHP>; Tue, 23 Oct 2001 12:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277851AbRJWQHF>; Tue, 23 Oct 2001 12:07:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30214 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277849AbRJWQGt>; Tue, 23 Oct 2001 12:06:49 -0400
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
To: cort@fsmlabs.com (Cort Dougan)
Date: Tue, 23 Oct 2001 17:13:38 +0100 (BST)
Cc: tegeran@home.com (Nicholas Knight), drevil@warpcore.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011022230631.A976@ftsoj.fsmlabs.com> from "Cort Dougan" at Oct 22, 2001 11:06:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15w4BO-0006P8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the binary only module in question sticks with the "published
> interface" (as is required) isn't it a problem in Linux then?

But if it stuck the published interface it would work. Clearly. 8)

Thats the problem - nobody knows why it breaks, and its a complex driver
doing trick memory management hacks (or at least the older version I 
got bored enough to reverse engineer a bit to look at the problems did) and
may well do other horrible things

Alan
