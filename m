Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUHXChw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUHXChw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 22:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUHXChv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 22:37:51 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:28827 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266752AbUHXCeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 22:34:25 -0400
Date: Mon, 23 Aug 2004 22:34:18 -0400
From: Tom Vier <tmv@comcast.net>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Message-ID: <20040824023418.GD12622@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408202211.46854.rjwysocki@sisk.pl> <200408201617.09245.gene.heskett@verizon.net> <200408220105.25734.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408220105.25734.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 01:05:25AM -0400, Gene Heskett wrote:
> Whereas the error was always at an odd address, and in the 2nd LSbyte, 
> now its still an odd address but the error has moved to the MSB of a 
> 32 bit fetch:

are you translating virt->phys?

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
