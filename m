Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310168AbSCFUpd>; Wed, 6 Mar 2002 15:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310172AbSCFUpN>; Wed, 6 Mar 2002 15:45:13 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:47624 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S310168AbSCFUpC>; Wed, 6 Mar 2002 15:45:02 -0500
Date: Wed, 6 Mar 2002 12:45:01 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Ben Greear <greearb@candelatech.com>
cc: Davide Libenzi <davidel@xmailserver.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: a faster way to gettimeofday?
In-Reply-To: <3C859909.30602@candelatech.com>
Message-ID: <Pine.LNX.4.33.0203061238380.17114-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Ben Greear wrote:

>
> Davide Libenzi wrote:
>
> > If you're on x86 you can use collect rdtsc samples and convert them to ms.
> > You'll get even more then ms accuracy.
>
>
> Can I do this from user space?  If so, any examples or docs
> you can point me to?
>
> Also, I'm looking primarily for a speed increase, not an accuracy
> increase.

ingo started the proper work for this, for example, see:
<http://people.redhat.com/mingo/vsyscall-patches/vsyscall-2.3.32-F4>
(there's a documentation file near the bottom of the patch)  but it
doesn't appear to support gettimeofday via rdtsc yet.

-dean


