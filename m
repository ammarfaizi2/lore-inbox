Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290317AbSAPBLr>; Tue, 15 Jan 2002 20:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290321AbSAPBLi>; Tue, 15 Jan 2002 20:11:38 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:11022 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S290317AbSAPBL2>; Tue, 15 Jan 2002 20:11:28 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Jan 2002 17:17:24 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, John Weber <weber@nyc.rr.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
In-Reply-To: <Pine.LNX.4.33.0201151641260.1213-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0201151710310.944-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Linus Torvalds wrote:

>
> On Tue, 15 Jan 2002, Davide Libenzi wrote:
> >
> > after that it builds for me ... but it crashes at boot time
>
> Where?
>
> The main big thing in 2.5.3-pre1 is the IDE driver update, the rest looks
> fairly simple. I've tested the new IDE driver on my system (the famous
> "Works For Me" test), and it's been tested quite a lot in earlier
> incarnations on other platforms, but there might easily be some BIO or
> low-level IDE chipset interactions.
>
> If it's not in the IDE driver, I'm at a loss.

Doh !

Trace; c0113988 <schedule+118/2b0>
Trace; c01075cd <sys_clone+1d/30>
Trace; c0105020 <init+0/140>
Trace; c0105000 <_stext+0/0>
Trace; c010720d <kernel_thread+1d/30>
Trace; c0105011 <rest_init+11/20>

Let me try something ...




- Davide


