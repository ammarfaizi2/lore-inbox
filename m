Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132392AbRDWWP4>; Mon, 23 Apr 2001 18:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132421AbRDWWOR>; Mon, 23 Apr 2001 18:14:17 -0400
Received: from dire.bris.ac.uk ([137.222.10.60]:55017 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id <S132392AbRDWWNF>;
	Mon, 23 Apr 2001 18:13:05 -0400
Date: Mon, 23 Apr 2001 23:09:44 +0100 (BST)
From: Matt <madmatt@bits.bris.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: ioctl arg passing
In-Reply-To: <Pine.LNX.4.21.0104231648330.1089-100000@bits.bris.ac.uk>
Message-ID: <Pine.LNX.4.21.0104232301270.8859-100000@bits.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt mentioned the following:

| struct instruction_t {
| 	__s16 code;
| 	__s16 rxlen;
| 	__s16 *rxbuf;
| 	__s16 txlen;
| 	__s16 *txbuf;
| };

So far, I now know I can grab stuff across the user <-> kernel divide as I
planned. The only problem I'm left with, which was kindly pointed out to
me, is a question of packing with respect to both kernel & user-space.

Can anyone suggest a method of either assuring the above structure is
always packed the same, or alterations so that the problem is
minimised? Either splitting the one ioctl into many, etc.

Thanks

Matt

