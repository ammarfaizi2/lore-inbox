Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSERQhY>; Sat, 18 May 2002 12:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313492AbSERQhX>; Sat, 18 May 2002 12:37:23 -0400
Received: from smtp-out-1.wanadoo.fr ([193.252.19.188]:25528 "EHLO
	mel-rto1.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S313305AbSERQhX>; Sat, 18 May 2002 12:37:23 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Cc: <linux-ide@vger.kernel.org>
Subject: Re: IO/MMIO 2.4 ATA/IDE driver recore near complete
Date: Fri, 17 May 2002 04:15:15 +0100
Message-Id: <20020517031515.20062@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.10.10205180230290.774-100000@master.linux-ide.org>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Please note BMDMA for MMIO is not native since there appears to be
>pci-posting errors under x86.

Can you elaborate ? I had to deal with driver bugs related to
PCI wr. posting in the past. I assume you know what you are doing,
but just in case, you missed a SW bug, I may be able to help.

Ben.


