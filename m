Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312212AbSDST6x>; Fri, 19 Apr 2002 15:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312308AbSDST6w>; Fri, 19 Apr 2002 15:58:52 -0400
Received: from klecker.debian.org ([198.186.203.20]:25874 "EHLO
	klecker.debian.org") by vger.kernel.org with ESMTP
	id <S312212AbSDST6v>; Fri, 19 Apr 2002 15:58:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Yven Leist <leist@beldesign.de>
Organization: beldesign
To: Andi Kleen <ak@suse.de>
Subject: Re: TCP: Treason uncloaked DoS ??
Date: Fri, 19 Apr 2002 21:58:34 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200204191512.g3JFCvl18558@mail.advfn.com.suse.lists.linux.kernel> <p731ydbacja.fsf@oldwotan.suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020419195836.9B9A343253C@fastpage.beldesign.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 April 2002 18:17, Andi Kleen wrote:
> Tim Kay <timk@advfn.com> writes:
> > that the connections are kept open if the client connecting doesn't
> > actually go away so surely lots of these ocurring at once would overload
> > a server. I have googled this and an occasional instance seems normal and
> > could be down to a broken client, but lots from different IP addr's at
> > once??
>
> It is a TCP bug of the other side.

that's strange, I encountered exactly the same message in my syslog while 
doing backups between two Linux machines, it was somewhere around 2.4.15 I 
think.

> You can safely comment out the printk. It would be interesting however
> to find out what the other side is running and yell at the vendor.
>
> > I'm a bit concerned that maybe someone is warming up for a hit or
> > something.
>
> More likely someone released a new buggy TCP stack to the world.

Is it possible that there are other things which can cause this? 
Or does it really mean that Linux has a buggy TCP stack!? 
I simply cannot believe this ;-)
cheers,
Yven

-- 

Yven Johannes Leist - leist@beldesign.de
http://www.leist.beldesign.de
