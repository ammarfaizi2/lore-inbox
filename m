Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130559AbQKRAjS>; Fri, 17 Nov 2000 19:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130335AbQKRAjI>; Fri, 17 Nov 2000 19:39:08 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:35600 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S130552AbQKRAjB>;
	Fri, 17 Nov 2000 19:39:01 -0500
Date: Fri, 17 Nov 2000 16:09:00 -0800
From: "H . J . Lu" <hjl@valinux.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: lseek/llseek allows the negative offset
Message-ID: <20001117160900.A27010@valinux.com>
In-Reply-To: <20001117155913.A26622@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001117155913.A26622@valinux.com>; from hjl@valinux.com on Fri, Nov 17, 2000 at 03:59:13PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 03:59:13PM -0800, H . J . Lu wrote:
> # gcc x.c
> # ./a.out
> lseek on -100000: -100000
> write: File too large
> 
> Should kernel allow negative offsets for lseek/llseek?
> 
> 

Never mind. I was running the wrong kernel.

H.J.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
