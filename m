Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265986AbTGDLYX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 07:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265989AbTGDLYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 07:24:23 -0400
Received: from home.wiggy.net ([213.84.101.140]:58062 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S265986AbTGDLYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 07:24:22 -0400
Date: Fri, 4 Jul 2003 13:38:50 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 and 2.5.74 freeze on cardmgr start
Message-ID: <20030704113850.GF20486@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030704090329.GA1975@wiggy.net> <20030704102018.A4374@flint.arm.linux.org.uk> <20030704093732.GA2159@wiggy.net> <20030704113156.E4374@flint.arm.linux.org.uk> <20030704103725.GA2306@wiggy.net> <20030704121853.F4374@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704121853.F4374@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Russell King wrote:
> Argh, ok.  Are you prepared to run through up to about 8 interations
> using a binary search method to find the pesky port / range of ports?

Got it. The problematic port range is 0x810 - 0x817. Excluding that
subset and using "include port 0x800-0x80f, port 0x818-0x8ff" instead
works fine.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>      It is simple to make things.
http://www.wiggy.net/                     It is hard to make things simple.

