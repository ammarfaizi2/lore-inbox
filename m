Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314282AbSDVRRU>; Mon, 22 Apr 2002 13:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSDVRRT>; Mon, 22 Apr 2002 13:17:19 -0400
Received: from [193.120.151.1] ([193.120.151.1]:65012 "EHLO mail.asitatech.com")
	by vger.kernel.org with ESMTP id <S314282AbSDVRRT>;
	Mon, 22 Apr 2002 13:17:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: DJ Barrow <dj.barrow@asitatech.com>
Organization: Asita Technologies
To: Andi Kleen <ak@suse.de>
Subject: Re: novice coding in /linux/net/ipv4/util.c From: DJ Barrow <dj.barrow@asitatech.com>
Date: Mon, 22 Apr 2002 18:19:16 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020422151025Z314220-22651+13849@vger.kernel.org.suse.lists.linux.kernel> <p73it6j8xwl.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020422171719Z314282-22651+13900@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds reasonable to me.

On Monday 22 April 2002 18:07, Andi Kleen wrote:
> DJ Barrow <dj.barrow@asitatech.com> writes:
> > This textbook peice of novice coding which has existed since 2.2.14.
>
> Even earlier I think
>
> BTW do you call libresolv novice coding too ?
>
> > For those who can't spot the error, please note that this function is
> > returning a static string, excellent stuff if you are hoping to reuse the
> > same function like the following
> > printk("%s %s\n",in_ntoa(addr1),in_ntoa(addr2));
>
> That is why most of networking uses the NIPQUAD macro instead.
>
> Best would be probably to convert the few remaining users of in_ntoa
> to NIPQUAD and drop this function.
>
> -Andi