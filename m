Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130693AbRCEVtz>; Mon, 5 Mar 2001 16:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130702AbRCEVtv>; Mon, 5 Mar 2001 16:49:51 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:36091 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S130693AbRCEVsb>; Mon, 5 Mar 2001 16:48:31 -0500
Date: Mon, 5 Mar 2001 13:48:04 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: John Kodis <kodis@mail630.gsfc.nasa.gov>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010305095512.A30787@tux.gsfc.nasa.gov>
Message-ID: <Pine.LNX.4.21.0103051344570.32408-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, John Kodis wrote:

> On Mon, Mar 05, 2001 at 08:40:22AM -0500, Richard B. Johnson wrote:
> 
> > Somebody must have missed the boat entirely. Unix does not, never
> > has, and never will end a text line with '\r'.
> 
> Unix does not, never has, and never will end a text line with ' ' (a
> space character) or with \t (a tab character).  Yet if I begin a shell
> script with '#!/bin/sh ' or '#!/bin/sh\t', the training white space is
> striped and /bin/sh gets exec'd.  Since \r has no special significance
> to Unix, I'd expect it to be treated the same as any other whitespace
> character -- it should be striped, and /bin/sh should get exec'd.

umm, last i checked a carriage return wasn't whitespace...
space, horizontal tab, vertical tab, form feed constitute whitespace
IIRC...

 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

