Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUEFU5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUEFU5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 16:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbUEFU5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 16:57:43 -0400
Received: from host82-70.pool21345.interbusiness.it ([213.45.70.82]:27408 "EHLO
	casapigi.pigi.org") by vger.kernel.org with ESMTP id S263003AbUEFU5l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 16:57:41 -0400
Message-ID: <33051.192.168.130.78.1083877056.squirrel@192.168.130.78>
Date: Thu, 6 May 2004 22:57:36 +0200 (CEST)
Subject: [BUG] 2.6.5 e100 on 10Mbps 
From: pigi@casapigi.pigi.org
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.
I'm having some trouble make the e100 working on a 10 Mbit half duplex lan.
It seems to work fine for 40/50 minutes then simply hangs and I need to
ifconfig down/up to restart.
There is no message neither in dmesg nor in messages/dmesg files.
I have already patched the sources with Scott Feldman patch. Before this
patch the time my ethernet was working was really little, so this patch
makes things better, but not fixed the problem completely.
What I've noticed is that also compiling the old e100 driver ( from 2.6.3
) that in 2.6.3 was working fine don't fix the problem, so I suspect thet
the problem should be elsewhere.

Must say that on a 100 Mbit switched lan I have no problem with both
version of driver.

Any idea on this bug ?

Pigi
