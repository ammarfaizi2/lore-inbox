Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312164AbSCRBn7>; Sun, 17 Mar 2002 20:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312166AbSCRBnu>; Sun, 17 Mar 2002 20:43:50 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:29312 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S312165AbSCRBnd>; Sun, 17 Mar 2002 20:43:33 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 17 Mar 2002 17:48:02 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <20020318014051.GA2254@matchmail.com>
Message-ID: <Pine.LNX.4.44.0203171746590.7378-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2002, Mike Fedyk wrote:

> On Sun, Mar 17, 2002 at 05:13:16PM -0800, Davide Libenzi wrote:

> > What's the reason that would make more convenient for us, upon receiving a
> > request to map a NNN MB file, to map it using 4Kb pages instead of 4MB ones ?
>
> ... the VM chooses to unmap a mmaped page, it chooses a 4mb page, later it
> needs just a few bytes from that unmaped page and free 4mb instead of 4kb (worst
> case) to map that page again...

The big-page property should be vma related and should be obviously
handled correctly ...



- Davide


