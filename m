Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268440AbRHFNQH>; Mon, 6 Aug 2001 09:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268453AbRHFNP6>; Mon, 6 Aug 2001 09:15:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24593 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268440AbRHFNPq>; Mon, 6 Aug 2001 09:15:46 -0400
Subject: Re: /proc/<n>/maps getting _VERY_ long
To: cw@f00f.org (Chris Wedgwood)
Date: Mon, 6 Aug 2001 14:17:32 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hpa@zytor.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010807002320.A23937@weta.f00f.org> from "Chris Wedgwood" at Aug 07, 2001 12:23:20 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TkGC-0000z3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Aug 06, 2001 at 12:52:37PM +0100, Alan Cox wrote:
> 
>     That would explain a lot since mprotect currently doesn't seem to do
>     merging, and worse it also seems to not be doing rlimit checking right
> 
> Err stupid question, but why does it need to do rlimit checking?

mmap nothing over a large space
mprotect it read/write

