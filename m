Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288001AbSACAB4>; Wed, 2 Jan 2002 19:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288063AbSACAAz>; Wed, 2 Jan 2002 19:00:55 -0500
Received: from ns.suse.de ([213.95.15.193]:44806 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288065AbSACAAY>;
	Wed, 2 Jan 2002 19:00:24 -0500
Date: Thu, 3 Jan 2002 01:00:23 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Mike Castle <dalgoda@ix.netcom.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        "Eric S. Raymond" <esr@thyrsus.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102235600.GA28621@thune.mrc-home.com>
Message-ID: <Pine.LNX.4.33.0201030059130.5131-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Mike Castle wrote:

> It's not just a simple od -c type of output that a post-processor could
> decode turn back into binary and decode.  The routine would still have to
> locate the DMI table, and decode at least the appropriate length of the
> table, present that to the output, and then dump the output in hex format
> or something.  Why risk getting that wrong and screwing up kernel internals
> when it can already be done in userspace?

And as I've already pointed out twice it isn't a bullet proof solution to
use DMI anyway in this circumstance.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

