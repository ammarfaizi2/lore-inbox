Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130454AbQLTVvr>; Wed, 20 Dec 2000 16:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130540AbQLTVv1>; Wed, 20 Dec 2000 16:51:27 -0500
Received: from nat-hdqt.valinux.com ([198.186.202.17]:37672 "EHLO
	earth.su.valinux.com") by vger.kernel.org with ESMTP
	id <S130454AbQLTVvS>; Wed, 20 Dec 2000 16:51:18 -0500
Date: Wed, 20 Dec 2000 14:28:28 -0800
From: Dragan Stancevic <visitor@valinux.com>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: Tom Murphy <freyason@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12-pre7 shutdowns and eepro100 woes
Message-ID: <20001220142828.B32335@valinux.com>
In-Reply-To: <20001211185219.28022.qmail@web2006.mail.yahoo.com> <20001212142846.A14979@saw.sw.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <20001212142846.A14979@saw.sw.com.sg>; from Andrey Savochkin on Tue, Dec 12, 2000 at 02:28:46PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2000, Andrey Savochkin <saw@saw.sw.com.sg> wrote:
; To answer your question in short, yet, we hope to fix the problem sooner or
; later.


I added the print out of the message to see in what state was the card
being left after it was wedged.

The card seems to be locking up with undefined opcodes, atleast according to
my specs. 

The command doesn't necessarly come from the driver, I'we done some
experimenting and it seems that sending the card an undefined opcode
will lock up the card with a different value in the command register.

I am still waiting for latest specs from intel, I wonder if the new
specs will define those values.


-- 
I knew I was alone, I was scared, it was getting dark and
it was a hardware problem.

                                                -Dragan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
