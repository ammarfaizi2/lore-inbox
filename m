Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265481AbSJRXTL>; Fri, 18 Oct 2002 19:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265482AbSJRXTL>; Fri, 18 Oct 2002 19:19:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10507 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265481AbSJRXTL>; Fri, 18 Oct 2002 19:19:11 -0400
Date: Fri, 18 Oct 2002 16:27:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
cc: Davide Libenzi <davidel@xmailserver.org>, Hanna Linder <hannal@us.ibm.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: [PATCH] sys_epoll system call interface to /dev/epoll
In-Reply-To: <3DB094B0.2040400@watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0210181626260.1231-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Oct 2002, Shailabh Nagar wrote:
> 
> Apart from the multiple vs. single system call issue, are you okay with
> the creation of an fd,file * etc. without having a device ?

Hey, that's the UNIX way. Think sockets, think pipes, think futexes. It's 
nothing new, it's been there in Unix since 1969, and the "everything is a 
file" thing has nothing to say about using "open".

		Linus

