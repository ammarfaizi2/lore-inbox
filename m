Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278926AbRJVVAa>; Mon, 22 Oct 2001 17:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278925AbRJVVAU>; Mon, 22 Oct 2001 17:00:20 -0400
Received: from thornbush.demon.co.uk ([194.222.0.69]:11648 "EHLO
	thornbush.demon.co.uk") by vger.kernel.org with ESMTP
	id <S278917AbRJVVAD>; Mon, 22 Oct 2001 17:00:03 -0400
Date: Mon, 22 Oct 2001 22:01:02 +0100 (BST)
From: Darren Durbin <ddurbin@thornbush.demon.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Freeze with 'alloc_skb called nonatomically'
Message-ID: <Pine.LNX.4.33.0110222147430.1064-100000@thornbush.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am getting repeatable machine freezes when trying to bring up a second
channel with my Elsa PCI ISDN card. The system is RedHat 7.1.

Whenever it attempts to bring up a second line I get a message saying
'alloc_skb clled nonatomically from interrupt c01f8c13'. The whole
machine then freezes and a reboot is required. The nearest symbol in System.map
is rtmsg_fib.

I've tried various different -ac kernels, from 2.4.10-ac4 upto 2.4.12-ac5
and all seem to exhibit the same behaviour

Regards,
Darren

