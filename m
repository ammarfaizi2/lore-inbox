Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132680AbRAIXn2>; Tue, 9 Jan 2001 18:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132041AbRAIXnW>; Tue, 9 Jan 2001 18:43:22 -0500
Received: from ns.sysgo.de ([213.68.67.98]:3064 "EHLO rob.devdep.sysgo.de")
	by vger.kernel.org with ESMTP id <S131809AbRAIXnN>;
	Tue, 9 Jan 2001 18:43:13 -0500
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rob@sysgo.de
To: linux-kernel@vger.kernel.org
Subject: Re: Anybody got 2.4.0 running on a 386 ?
Date: Wed, 10 Jan 2001 00:42:44 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.21.0101100527220.23018-100000@bee.lk>
In-Reply-To: <Pine.LNX.4.21.0101100527220.23018-100000@bee.lk>
MIME-Version: 1.0
Message-Id: <01011000420402.03050@rob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mit, 10 Jan 2001 you wrote:
> How big is the kernel image? Are you making a zImage or bzImage?
> 

I'm using bzImage. It's size is 566964 bytes.

According to System.map, Symbol _end is 0xc0252cf0. That would mean
the uncompressed kernel size would be 1387760 bytes (0xc0252cf0-0xc0100000),
right ?

----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
