Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293532AbSCOX6t>; Fri, 15 Mar 2002 18:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293538AbSCOX6o>; Fri, 15 Mar 2002 18:58:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4371 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293532AbSCOX61>; Fri, 15 Mar 2002 18:58:27 -0500
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
To: davem@redhat.com (David S. Miller)
Date: Sat, 16 Mar 2002 00:14:12 +0000 (GMT)
Cc: davids@webmaster.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020315.155432.32126270.davem@redhat.com> from "David S. Miller" at Mar 15, 2002 03:54:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16m1ps-00057f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    	One factor that would go into that decision is whether the
>    patch would have a chance at being accepted into the kernel
> 
> Hmmm... ignoring whether rfc2385 is stupid or not, don't
> we have crypto issues if we put something using MD5 into the tree?

MD5 is authentication not encryption. We already use it extensively.

Alan

