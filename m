Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbTAXROy>; Fri, 24 Jan 2003 12:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbTAXROy>; Fri, 24 Jan 2003 12:14:54 -0500
Received: from air-2.osdl.org ([65.172.181.6]:56496 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261486AbTAXROw>;
	Fri, 24 Jan 2003 12:14:52 -0500
Date: Fri, 24 Jan 2003 09:18:25 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <rpjday@mindspring.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: test suite?
In-Reply-To: <1043426077.1620.10.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L2.0301240850070.9816-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| From: Robert P. J. Day <rpjday@mindspring.com>
|
|   i've noticed references to "test suites" for kernels, but
| is there any one-step convenient way to select every possible
| option for test-compiling a new kernel, just to see if it builds?
| perhaps an "everything" option?
|
|   and, related to that, should such a kernel theoretically
| work?  as in, are there any options that would be mutually
| exclusive that would cause such a build to fail?
|
| still thinking about reorganizing the overall option structure,

Hi,

I notice that you've already had a reply on this (use "make help",
"make allmodconfig" or "make allyesconfig" etc.).

OSDL's PLM does this (make allmodconfig) for each new (2.5) kernel
release and the results are posted at
  http://www.osdl.org/archive/cherry/stability/
and also in the PLM web page interface.
The script that is used for this is at that same URL above.
PLM is at http://www.osdl.org/cgi-bin/plm/ .

Has anyone tried to boot an 'allyesconfig' kernel?
I'll give that a shot now.

HTH.
-- 
~Randy

