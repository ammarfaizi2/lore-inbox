Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316155AbSEQNYg>; Fri, 17 May 2002 09:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316173AbSEQNYf>; Fri, 17 May 2002 09:24:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22283 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316155AbSEQNYf>; Fri, 17 May 2002 09:24:35 -0400
Subject: Re: AUDIT: copy_from_user is a deathtrap.
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Fri, 17 May 2002 13:58:53 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davem@redhat.com (David S. Miller),
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <E178gkH-0001LV-00@wagner.rustcorp.com.au> from "Rusty Russell" at May 17, 2002 10:21:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178hJt-0006Rb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, the 400+ are all of form:
> 
> 	/* of course this returns 0 or -EFAULT! */
> 	return copy_from_user(xxx);

So lets verify and fix them. Post the list to the kenrel janitors
