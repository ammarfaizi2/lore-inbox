Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265036AbSJOXvx>; Tue, 15 Oct 2002 19:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265040AbSJOXvx>; Tue, 15 Oct 2002 19:51:53 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:24726 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265036AbSJOXvw>; Tue, 15 Oct 2002 19:51:52 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Oct 2002 17:05:53 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
In-Reply-To: <3DACA5E4.7090509@netscape.com>
Message-ID: <Pine.LNX.4.44.0210151701100.1554-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, John Gardiner Myers wrote:

> The epoll API is deficient--it is subtly error prone and it forces work
> on user space that is better done in the kernel.  That the API is
> specified in a deficient way does not make it any less deficient.

Just a simple question : Have you ever used RT-Signal API ? Is it the API
"deficent" or is it the one that does not understand it ? Do you know the
difference between level triggered ( poll() - select() - /dev/poll ) and
edge triggered ( /dev/epoll - RT-Signal ) interfaces ?




- Davide


