Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268873AbUHUHMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268873AbUHUHMW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 03:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268874AbUHUHMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 03:12:22 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:15624 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268873AbUHUHMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 03:12:21 -0400
Date: Sat, 21 Aug 2004 08:54:13 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Chris Johns <cbjohns@mn.rr.com>
Cc: linux-kernel@vger.kernel.org, kaos@oss.sgi.com
Subject: Re: Dumping kernel log (dmesg) and backtraces after a panic
Message-ID: <20040821065413.GF1456@alpha.home.local>
References: <C14859EA-F318-11D8-9C0E-000A958E2366@mn.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C14859EA-F318-11D8-9C0E-000A958E2366@mn.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 09:21:05PM -0500, Chris Johns wrote:
 
> To put it simply, is there either an alternative to KDB that works with 
> RH EL3 and provides what I need (bt and dmesg, or just dmesg), or is 
> there a version of KDB that would work with EL3 already?

I don't know if there's a specific KDB version, but you might give a try
to kmsgdump, it's not so intrusive and might apply on RHEL kernel. It will
allow you to dump the dmesg log buffer onto a floppy disk or a parallel
printer upon panic or on demand.

Cheers,
Willy

