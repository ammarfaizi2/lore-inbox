Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267026AbTBFMcC>; Thu, 6 Feb 2003 07:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267081AbTBFMcC>; Thu, 6 Feb 2003 07:32:02 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:28594 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267026AbTBFMcB>;
	Thu, 6 Feb 2003 07:32:01 -0500
Date: Thu, 6 Feb 2003 12:37:51 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Patrick Mau <mau@oscar.ping.de>, linux-kernel@vger.kernel.org
Subject: Re: pdflush in D state
Message-ID: <20030206123751.GB3305@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>, Patrick Mau <mau@oscar.ping.de>,
	linux-kernel@vger.kernel.org
References: <20030205231259.GA5339@oscar.ping.de> <20030205234139.237887a7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205234139.237887a7.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 11:41:39PM -0800, Andrew Morton wrote:

 > At a guess, I'd say that a disk device driver has dropped an interrupt and
 > I/O completion has not happened.
 > 
 > Check your kernel log and dmesg output for anything untoward, and then try
 > invoking sysrq-P and sysrq-T to find out where everythihg is stuck.

Unrelated to this problem, but it reminded me...
I've not heard any compelling arguments saying that these[1] patches
are wrong.

		Dave

[1] http://www.uwsg.iu.edu/hypermail/linux/kernel/0301.1/2217.html

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
