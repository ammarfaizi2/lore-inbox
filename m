Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285219AbRLFV3x>; Thu, 6 Dec 2001 16:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285220AbRLFV3e>; Thu, 6 Dec 2001 16:29:34 -0500
Received: from dsl-213-023-038-110.arcor-ip.net ([213.23.38.110]:45318 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S285219AbRLFV31>;
	Thu, 6 Dec 2001 16:29:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>
Subject: Re: SMP/cc Cluster description
Date: Thu, 6 Dec 2001 22:30:23 +0100
X-Mailer: KMail [version 1.3.2]
Cc: lm@bitmover.com, davidel@xmailserver.org, rusty@rustcorp.com.au,
        Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011206115338.E27589@work.bitmover.com> <20011206.121554.106436207.davem@redhat.com> <20011206122116.H27589@work.bitmover.com>
In-Reply-To: <20011206122116.H27589@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16C665-0000r5-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 6, 2001 09:21 pm, Larry McVoy wrote:
> On Thu, Dec 06, 2001 at 12:15:54PM -0800, David S. Miller wrote:
> > If you aren't getting rid of this locking, what is the point?
> > That is what we are trying to talk about.
> 
> The points are:
> 
> a) you have to thread the entire kernel, every data structure which is a
>    problem.  Scheduler, networking, device drivers, everything.  That's
>    thousands of locks and uncountable bugs, not to mention the impact on
>    uniprocessor performance.
> 
> b) I have to thread a file system.

OK, this is your central point.  It's a little more than just a mmap, no?
We're pressing you on your specific ideas on how to handle the 'peripheral' 
details.

--
Daniel
