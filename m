Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143705AbRAHNi0>; Mon, 8 Jan 2001 08:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143781AbRAHNiR>; Mon, 8 Jan 2001 08:38:17 -0500
Received: from [172.16.18.67] ([172.16.18.67]:3458 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S143705AbRAHNiE>; Mon, 8 Jan 2001 08:38:04 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E14FalM-0004MY-00@the-village.bc.nu> 
In-Reply-To: <E14FalM-0004MY-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: viro@math.psu.edu (Alexander Viro),
        stefan@hello-penguin.com (Stefan Traby), linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jan 2001 13:37:15 +0000
Message-ID: <27841.978961035@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  I put it into generic_file_write. That covers most fs's it seems. The
> jffs  guys are going to switch to generic_file_write soon 

It's in CVS already. For 2.4, 'soon' == 'when Linus is ready to start taking
patches'

If you want it for 2.4-ac I can provide a patch which fixes both that and 
the oops on open() unlink() read().

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
