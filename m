Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313777AbSDHWDk>; Mon, 8 Apr 2002 18:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313780AbSDHWDj>; Mon, 8 Apr 2002 18:03:39 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:23430 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S313777AbSDHWB7>; Mon, 8 Apr 2002 18:01:59 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 8 Apr 2002 15:08:37 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "J.A. Magallon" <jamagallon@able.es>
cc: "Kuppuswamy, Priyadarshini" <Priyadarshini.Kuppuswamy@compaq.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: system call for finding the number of cpus??
In-Reply-To: <20020408215814.GC13043@werewolf.able.es>
Message-ID: <Pine.LNX.4.44.0204081506460.1498-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002, J.A. Magallon wrote:

>
> On 2002.04.08 Davide Libenzi wrote:
> >On Mon, 8 Apr 2002, Kuppuswamy, Priyadarshini wrote:
> >
> >> Hi!
> >>   I have a script that is using the /cpu/procinfo file to determine the
> >> number of cpus present in the system. But I would like to implement it
> >> using a system call rather than use the environment variables?? I
> >> couldn't find a system call for linux that would give me the result.
> >> Could anyone please let me know if there is one for redhat linux??
> >
> >sysconf(_SC_NPROCESSORS_CONF);
> >
>
> I din't really trusted you, so digged inside includes till bits/confname.h
> Why the h*ll the manpage about sysconf does not talk about that ?????

.h files usually changes ofter than man pages mainly because developers
like to code not to document



- Davide


