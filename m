Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284470AbRLRSEl>; Tue, 18 Dec 2001 13:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284445AbRLRSEb>; Tue, 18 Dec 2001 13:04:31 -0500
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:30170 "HELO
	skytrain.rus.uni-stuttgart.de") by vger.kernel.org with SMTP
	id <S284421AbRLRSE2>; Tue, 18 Dec 2001 13:04:28 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Security issues in 2.4.9 and beyond
In-Reply-To: <Pine.LNX.4.21.0112012237350.13986-100000@tux.rsn.bth.se>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 18 Dec 2001 19:04:14 +0100
In-Reply-To: <Pine.LNX.4.21.0112012237350.13986-100000@tux.rsn.bth.se> (Martin Josefsson's message of "Sat, 1 Dec 2001 22:38:05 +0100 (CET)")
Message-ID: <87d71cjtgh.fsf@skytrain.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson <gandalf@wlug.westbo.se> writes:

> > This is what I have so far for 2.4.9:
> > 1. Netfilter mac address matching bug
> > 2. ptrace race condition
> > 3. symlink DoS
> > 4. syncookie/netfilter bug
> > 5. Netfilter FTP conntrack bug (can someone confirm this ??)
> 
> #5 was fixed in 2.4.5 I believe.

There are rumours about a buffer overflow in the PASV command, which
was silently fixed (it's not related to earlier FTP connection
tracking problems which could lead to filter evasion).

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
