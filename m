Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUBIEjx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 23:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbUBIEjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 23:39:53 -0500
Received: from leary.csoft.net ([63.111.22.80]:52376 "HELO mail63.csoft.net")
	by vger.kernel.org with SMTP id S264855AbUBIEjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 23:39:51 -0500
Message-ID: <40270F16.4070000@mattcaron.net>
Date: Sun, 08 Feb 2004 23:39:50 -0500
From: Matthew Caron <matt@mattcaron.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2 PROBLEMs: mkinitrd fails during make install (2.6.1) + first
 network connect fails after boot (2.6.1)
References: <40268B01.10608@mattcaron.net> <20040208190812.07703fce.rddunlap@osdl.org>
In-Reply-To: <20040208190812.07703fce.rddunlap@osdl.org>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Sun, 08 Feb 2004 14:16:17 -0500 Matthew Caron <matt@mattcaron.net> wrote:
> 
> | PROBLEM 1:
> | 
> | 1. Summary:
> | 	mkinitrd fails during make install (2.6.1)
> | 
> | 2. Description:
> | 	mkinitrd fails with error:
> | 
> | No module 3w-xxxx found for kernel 2.6.1
> | mkinitrd failed
> | make[1]: *** [install] Error 1
> | make: *** [install] Error 2
> | 
> | config command was: 'make xconfig'
> | build command was: 'make clean modules_install install'
> 
> What version of mkinitrd?  Please send output from 'mkinitrd --version'.
> Latest version seems to be 3.5.18.

mkinitrd: version 3.5.14

Bear in mind, this works on another machine running the same version of 
mkinitrd.

> [snipped]
> 
> 
> 
> Wow, I almost missed prob. 2.  Probably better as separate postings.

I thought about that, but decided to post them together, since each bug 
references the other - each bug only occurs on that machine, not another 
one with similar configuration.

> | PROBLEM 2:
> | 
> | 1. Summary:
> | 	first network connect fails after boot
> | 
> | 2. Description:
> | 	The first connection to any host on any port fails after boot/reboot. 
> | Subsequent connects work fine. Typical errors are:
> | 
> | ssh: connect to host foobar port 22: Resource temporarily unavailable
> | 
> | Firebird reports "Document Contains No Data"

<snipped>

-- 
Freedom to learn, freedom to share,
freedom to change, freedom to improve.
Free Software: it's about Freedom.
--------------------------------------------------------------------
PGP Key: http://www.mattcaron.net/pgp_key.txt
  ~~ Matt Caron ~~

