Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136613AbREJOFE>; Thu, 10 May 2001 10:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136612AbREJN7i>; Thu, 10 May 2001 09:59:38 -0400
Received: from zeus.kernel.org ([209.10.41.242]:54674 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136613AbREJN7Z>;
	Thu, 10 May 2001 09:59:25 -0400
Date: Wed, 9 May 2001 22:51:17 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] writepage method changes
In-Reply-To: <Pine.LNX.4.21.0105092134230.16052-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0105092245470.16087-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 May 2001, Marcelo Tosatti wrote:

> Locked for the "not wrote out case" (I will fix my patch now, thanks)

I just found out that there are filesystems (eg reiserfs) which write out
data even if an error ocurred, which means the unlocking must be done by
the filesystems, always. 


