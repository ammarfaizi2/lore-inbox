Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262064AbRENI0a>; Mon, 14 May 2001 04:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262236AbRENI0V>; Mon, 14 May 2001 04:26:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44554 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262064AbRENI0A>; Mon, 14 May 2001 04:26:00 -0400
Subject: Re: Minor numbers
To: aqchen@us.ibm.com (Alex Q Chen)
Date: Mon, 14 May 2001 09:22:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF2C42607E.899F4413-ON87256A4C.00068D2E@LocalDomain> from "Alex Q Chen" at May 13, 2001 06:28:46 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zDcI-0007TB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 255.  Has this limitation been some how addressed with 2.4?  256 devices
> per module, sometimes is not enough, especially if you are in the SAN
> environment; or when the 256 minors numbers are broken down to several

2.4 is using 16bit dev_t in kernel still. Application space sees a much
larger dev_t so we can make the move in 2.5 very easily

> work-around or is proposing a solution?  I believe that minor and major
> numbers for SUN and AIX are both 16 bits each (32 bits dev_t).

20:12 is more common
