Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRCENlG>; Mon, 5 Mar 2001 08:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129307AbRCENk4>; Mon, 5 Mar 2001 08:40:56 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11394 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129292AbRCENkt>; Mon, 5 Mar 2001 08:40:49 -0500
Date: Mon, 5 Mar 2001 08:40:22 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jan Nieuwenhuizen <janneke@gnu.org>
cc: Pavel Machek <pavel@suse.cz>, Erik Hensema <erik@hensema.xs4all.nl>,
        linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
In-Reply-To: <m3k8648i94.fsf@appel.lilypond.org>
Message-ID: <Pine.LNX.3.95.1010305083112.8719A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Mar 2001, Jan Nieuwenhuizen wrote:

> Pavel Machek <pavel@suse.cz> writes:
> 
> > > $ head -1 testscript
> > > #!/bin/sh
> > > $ ./testscript
> > > bash: ./testscript: No such file or directory
> > 
> > What kernel wants to say is "/usr/bin/perl\r: no such file". Saying ENOEXEC
> > would be even more confusing.
> 
> So, why don't we make bash say that, then?  As I guess that we've all
> been bitten by this before.
> 
> What are the chances for something like this to be included?
> 
> Greetings,
> Jan.
> 
[SNIPPED...]

So why would you even consider breaking bash as a work-around for
a broken script?

Somebody must have missed the boat entirely. Unix does not, never
has, and never will end a text line with '\r'. It's Microsoft junk
that does that, a throwback to CP/M, a throwback to MDS/200.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


