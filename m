Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132479AbRDWWdC>; Mon, 23 Apr 2001 18:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132482AbRDWWcl>; Mon, 23 Apr 2001 18:32:41 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:7177 "EHLO
	Opus.bloom.county") by vger.kernel.org with ESMTP
	id <S132471AbRDWWbm>; Mon, 23 Apr 2001 18:31:42 -0400
Date: Mon, 23 Apr 2001 15:30:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [upatch] lib/Makefile
Message-ID: <20010423153026.E19945@opus.bloom.county>
In-Reply-To: <20010423171624.B1690@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010423171624.B1690@cadcamlab.org>; from peter@cadcamlab.org on Mon, Apr 23, 2001 at 05:16:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 05:16:24PM -0500, Peter Samuelson wrote:

> Introduced in 2.4.4pre4, I believe.  $(export-objs) need not be
> conditional, and the if statement was not really correct either,
> although in this case it probably worked.

Er, are you sure changing the test for !"nn" is correct here?
I _think_ at least that is intentional and correct (since you can have
one on but not the other).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
