Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbTDDX3n (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 18:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbTDDX3n (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 18:29:43 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:30365 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261470AbTDDX3m (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 18:29:42 -0500
Date: Sat, 5 Apr 2003 00:41:01 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: some serious problems compiling 2.5.66-bk10
Message-ID: <20030404234035.GA19591@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0304041820540.21137-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304041820540.21137-100000@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >   but after i typed "make modules_install", the final
 > depmod generated some 2000 lines of unresolved symbols.
 > should i have expected this?

Yes. Lots of drivers still haven't been converted to use
new APIs, lots are still using cli/sti etc, some still
use the tqueue stuff, and a bunch of other similar issues..

		Dave
