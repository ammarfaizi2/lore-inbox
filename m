Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276181AbRI1RTK>; Fri, 28 Sep 2001 13:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276177AbRI1RTA>; Fri, 28 Sep 2001 13:19:00 -0400
Received: from suphys.physics.usyd.edu.au ([129.78.129.1]:39119 "EHLO
	suphys.physics.usyd.edu.au") by vger.kernel.org with ESMTP
	id <S276180AbRI1RSt>; Fri, 28 Sep 2001 13:18:49 -0400
Date: Sat, 29 Sep 2001 03:15:28 +1000 (EST)
From: Tim Connors <tcon@Physics.usyd.edu.au>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac16
In-Reply-To: <Pine.LNX.4.33L.0109281338590.26495-100000@duckman.distro.conectiva>
Message-ID: <Pine.SOL.3.96.1010929031241.5918A-100000@suphys.physics.usyd.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2001, Rik van Riel wrote:

> On Fri, 28 Sep 2001, Stefan Becker wrote:
> > Alan Cox wrote:
> > > *       Update the VM to Rik's latest bits
> >
> > "swapoff -a" gives:
> >
> > Sep 28 17:25:25 unknown kernel: Trying to vfree() nonexistent vm
> > area (e105a000)
> 
> It seems Al Viro forgot to remove a free() when cleaning
> up some code. Hugh Dickens has already posted a patch to
> fix this.

Hmmm. Just searched for it and can't find. Did find references to that
syslog entry being a potentially bad bug though. I presume it is
benign in this situation?


-- 
TimC -- http://www.physics.usyd.edu.au/~tcon/

"Eddies in the space time continuum"
"Oh. Is he?"

