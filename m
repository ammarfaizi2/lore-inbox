Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132691AbRDUPd5>; Sat, 21 Apr 2001 11:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132690AbRDUPdr>; Sat, 21 Apr 2001 11:33:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62475 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132691AbRDUPdb>; Sat, 21 Apr 2001 11:33:31 -0400
Subject: Re: Question about system generation
To: eccesys@topmail.de (Thorsten Glaser Geuer)
Date: Sat, 21 Apr 2001 16:35:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010421140524.92FAB984880@www.topmail.de> from "Thorsten Glaser Geuer" at Apr 21, 2001 04:05:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qzPp-0003r3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> when kernel 2.4 runs fine with gcc-3.0 when it's
> finished. I want to use libc5 because I prefer it
> over GNU and it's smaller. Is it possible or do
> I have to expect major problems? I know that I won't

It should work due the compatibility calls. It will probably cease to work
well in 2.5 however, once we go large device types. You will also miss out on
most of the 2.4 features with libc5

(in fact libc4 and libc2.2 still work)

Alan

