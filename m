Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292892AbSCMJnb>; Wed, 13 Mar 2002 04:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292896AbSCMJnV>; Wed, 13 Mar 2002 04:43:21 -0500
Received: from mail.sonytel.be ([193.74.243.200]:43701 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S292892AbSCMJnQ>;
	Wed, 13 Mar 2002 04:43:16 -0500
Date: Wed, 13 Mar 2002 10:39:28 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
cc: Hans Reiser <reiser@namesys.com>, James Antill <james@and.org>,
        Larry McVoy <lm@bitmover.com>, Tom Lord <lord@regexps.com>,
        jaharkes@cs.cmu.edu,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <20020312223738.GB29832@pimlott.ne.mediaone.net>
Message-ID: <Pine.GSO.4.21.0203131037240.17582-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2002, Andrew Pimlott wrote:
> On Tue, Mar 12, 2002 at 10:58:45AM +0300, Hans Reiser wrote:
> > Clearcase handles all of this in the filesystem, and it all works pretty 
> > much reasonably.
> 
> This is misleading--Clearcase stores versions on top a normal
> filesystem (like most other RCS's), and all manipulation is entirely
                                                              ^^^^^^^^
> in user-space (over the network to server processes).  There only
  ^^^^^^^^^^^^^
> filesystem magic is that there are directories you cannot list (plus
> permission semantics are a little funny).

So what's that ClearCase file system driver doing in kernel space? If your
claims are true, we wouldn't be limited to running some specific (buggy) Red
Hat kernel when we would want to migrate development from Solaris to Linux.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-2908453 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium

