Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267696AbTBQX0t>; Mon, 17 Feb 2003 18:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267645AbTBQX0L>; Mon, 17 Feb 2003 18:26:11 -0500
Received: from dhcp-66-212-193-131.myeastern.com ([66.212.193.131]:735 "EHLO
	mail.and.org") by vger.kernel.org with ESMTP id <S267687AbTBQXYq>;
	Mon, 17 Feb 2003 18:24:46 -0500
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
References: <Pine.LNX.4.44.0302131452450.4232-100000@penguin.transmeta.com>
	<Pine.LNX.4.50.0302141553020.988-100000@blue1.dev.mcafeelabs.com>
	<m3fzqpgxlx.fsf@code.and.org>
	<Pine.LNX.4.50.0302151430230.1891-100000@blue1.dev.mcafeelabs.com>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 17 Feb 2003 18:34:39 -0500
In-Reply-To: <Pine.LNX.4.50.0302151430230.1891-100000@blue1.dev.mcafeelabs.com>
Message-ID: <m3smumfpm8.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> writes:

> On Sat, 15 Feb 2003, James Antill wrote:
> 
> > > I would personally like it a lot to have timer events available on
> > > pollable fds. Am I alone in this ?
> >
> >  Think of "timer events" as a single TCP connection, so you have...
> 
> I'm sorry, I'm a bit confused. What's the point here ?

 Just that although you could have each timer event on separate
pollable fds it's much the same as having separate events for 1
byte, 2 bytes, and 4 bytes available on a network socket (Ie. you are
much better off keeping that all in user space).

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
