Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTKDW1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 17:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTKDW1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 17:27:18 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:59883 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S261168AbTKDW1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 17:27:17 -0500
Date: Tue, 4 Nov 2003 17:26:50 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Linus Torvalds <torvalds@osdl.org>, Paul Venezia <pvenezia@jpj.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: ext3 performance inconsistencies, 2.4/2.6
Message-ID: <20031104222650.GA8958@ti19.telemetry-investments.com>
Reply-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Linus Torvalds <torvalds@osdl.org>, Paul Venezia <pvenezia@jpj.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ulrich Drepper <drepper@redhat.com>
References: <20031104212813.GC30612@ti19.telemetry-investments.com> <Pine.LNX.4.44.0311041335200.20373-100000@home.osdl.org> <20031104221904.GE30612@ti19.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031104221904.GE30612@ti19.telemetry-investments.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04, 2003 at 05:19:04PM -0500, Bill Rugolsky Jr. wrote:
> On Fedora 0.95, Pentium M 1.6GHz, 2.4.22-1.2115.nptl, glibc-2.3.2-10, (NPTL 0.60),
> I get:
> 
> Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> NPTL           100M 13070 100 +++++ +++ 14141   4 13099 100 +++++ +++ +++++ +++
> LinuxThreads   100M 25957 100 +++++ +++ 20037   5 26777  99 +++++ +++ +++++ +++
 

Eek, that's glibc-2.3.2-101.
                          ^

 	- Bill Rugolsky
