Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262582AbTDAPFZ>; Tue, 1 Apr 2003 10:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262586AbTDAPFZ>; Tue, 1 Apr 2003 10:05:25 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:31363 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262582AbTDAPFY>; Tue, 1 Apr 2003 10:05:24 -0500
Date: Tue, 1 Apr 2003 16:16:40 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: LKML <linux-kernel@vger.kernel.org>, simon@mtds.com
Subject: Re: New: SSE2 enabled by default on Celeron (P4 based)
Message-ID: <20030401151640.GB28635@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Mikael Pettersson <mikpe@user.it.uu.se>,
	LKML <linux-kernel@vger.kernel.org>, simon@mtds.com
References: <17080000.1049207466@[10.10.2.4]> <16009.43013.754047.36875@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16009.43013.754047.36875@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 04:53:57PM +0200, Mikael Pettersson wrote:

 >  > Steps to reproduce: Compile kernel choosing *any* Celeron option
 >  > 
 >  > /proc/cpuinfo:-
 >  > processor       : 0
 >  > vendor_id       : GenuineIntel
 >  > cpu family      : 6
 >  > model           : 11
 > 
 > This is NOT a P4-based Celeron. It's a P6 Tualatin Celeron, and as such,
 > it does not support SSE2.
 > 
 > This CPU needs a kernel configured for a Pentium III or less.

The *any* part of the bug report doesn't make much sense.
That indicates that we're doing the wrong thing on the Pentium
III/Celeron option too.

		Dave

