Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbRGEW6l>; Thu, 5 Jul 2001 18:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265405AbRGEW6b>; Thu, 5 Jul 2001 18:58:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52750 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265402AbRGEW6T>; Thu, 5 Jul 2001 18:58:19 -0400
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ...
To: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 5 Jul 2001 23:57:11 +0100 (BST)
Cc: phillips@bonn-fries.net (Daniel Phillips),
        davidel@xmailserver.org (Davide Libenzi), linux-kernel@vger.kernel.org
In-Reply-To: <9515.994372983@redhat.com> from "David Woodhouse" at Jul 05, 2001 11:43:03 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15II3b-0003T8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Life's a bitch.
> cf. get_user(__ret_gu, __val_gu); (on i386)
> 
> Time to invent a gcc extension which gives us unique names? :)

#define min(a,b) __magic_minfoo(a,b, __var##__LINE__, __var2##__LINE__)

#define __magic_minfoo(A,B,C,D) \
	{ typeof(A) C = (A)  .... }


Alan

