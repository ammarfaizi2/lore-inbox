Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293402AbSCSAnF>; Mon, 18 Mar 2002 19:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293390AbSCSAm4>; Mon, 18 Mar 2002 19:42:56 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:24973 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293379AbSCSAml>; Mon, 18 Mar 2002 19:42:41 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Mar 2002 16:47:17 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "David S. Miller" <davem@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>, <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 7.52 second kernel compile
In-Reply-To: <20020318.162031.98995076.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0203181641050.1606-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002, David S. Miller wrote:

>    From: Linus Torvalds <torvalds@transmeta.com>
>    Date: Mon, 18 Mar 2002 14:46:04 -0800 (PST)
>
>    Or maybe the program is just flawed, and the interesting 1/8 pattern comes
>    from something else altogether.
>
> I think the weird Athlon behavior has to do with the fact that
> you've made your little test program as much of a cache tester
> as a TLB tester :-)

Uhm, it's moving to different pages and it does it consecutively. I think
Linus was trying to prove the multiple tlb entries fill for single miss ...



- Davide


