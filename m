Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129273AbRBNWkz>; Wed, 14 Feb 2001 17:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129418AbRBNWkp>; Wed, 14 Feb 2001 17:40:45 -0500
Received: from 216-175-174-69.client.dsl.net ([216.175.174.69]:6919 "HELO
	frank.eargle.com") by vger.kernel.org with SMTP id <S129273AbRBNWkd>;
	Wed, 14 Feb 2001 17:40:33 -0500
To: "Gord R. Lamb" <glamb@lcis.dyndns.org>
Subject: Re: Samba performance / zero-copy network I/O
Message-ID: <982190431.3a8b095f4b3c4@eargle.com>
Date: Wed, 14 Feb 2001 17:40:31 -0500 (EST)
From: Tom Sightler <ttsig@tuxyturvy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.32.0102141548440.27843-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.32.0102141548440.27843-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "Gord R. Lamb" <glamb@lcis.dyndns.org>:

> On Wed, 14 Feb 2001, Jeremy Jackson wrote:
> 
> > "Gord R. Lamb" wrote:
> > > in etherchannel bond, running
> linux-2.4.1+smptimers+zero-copy+lowlatency)

Not related to network, but why would you have lowlatency patches on this box?

My testing showed that the lowlatency patches abosolutely destroy a system
thoughput under heavy disk IO.  Sure, the box stays nice and responsive, but
something has to give.  On a file server I'll trade console responsivness for IO
performance any day (might choose the opposite on my laptop).

My testing wasn't very complete, but heavy dbench and multiple simultaneous file
copies both showed significantly lower performance with lowlatency enabled, and
returned to normal when disabled.

Of course you may have had lowlatency disabled via sysctl but I was mainly
curious if your results were different.

Later,
Tom
