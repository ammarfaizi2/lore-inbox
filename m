Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274505AbRJEXQg>; Fri, 5 Oct 2001 19:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274496AbRJEXQQ>; Fri, 5 Oct 2001 19:16:16 -0400
Received: from [208.129.208.52] ([208.129.208.52]:9476 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274509AbRJEXQO>;
	Fri, 5 Oct 2001 19:16:14 -0400
Date: Fri, 5 Oct 2001 16:21:38 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Davide Libenzi <davidel@xmailserver.org>,
        george anzinger <george@mvista.com>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Context switch times
In-Reply-To: <E15peDn-0007ze-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0110051619311.1523-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Oct 2001, Alan Cox wrote:

> > No, i mean T = (Tstart - Tend) where :
> >
> > Tstart = time the current ( prev ) task has been scheduled
> > Tend   = current time ( in schedule() )
> >
> > Basically it's the total time the current ( prev ) task has had the CPU
>
> Ok let me ask one question - why ?

Because the more the task is ran the higher the cache footprint is and the
higher the cache footprint is the more we'd like to pick up the exiting
task to rerun.




- Davide


