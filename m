Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267433AbUIKEoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267433AbUIKEoP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 00:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267482AbUIKEoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 00:44:15 -0400
Received: from peabody.ximian.com ([130.57.169.10]:12192 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267433AbUIKEoO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 00:44:14 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@ximian.com>
To: Daniel Stekloff <dsteklof@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Tim Hockin <thockin@hockin.org>,
       Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1094865815.2772.67.camel@localhost.localdomain>
References: <20040831150645.4aa8fd27.akpm@osdl.org>
	 <1093989924.4815.56.camel@betsy.boston.ximian.com>
	 <20040902083407.GC3191@kroah.com>
	 <1094142321.2284.12.camel@betsy.boston.ximian.com>
	 <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost>
	 <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org>
	 <20040910235409.GA32424@kroah.com> <20040911001849.GA321@hockin.org>
	 <20040911004827.GA8139@kroah.com>
	 <1094865815.2772.67.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 11 Sep 2004 00:45:26 -0400
Message-Id: <1094877926.12615.2.camel@lucy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-10 at 18:23 -0700, Daniel Stekloff wrote:

> Not to be cheeky, but cpu "overheating" isn't an error event? <grin>

I think the key importance is event vs. error.  E.g., "overheating" is a
state, something that can be handled in user-space.  A driver piping out
"error 501" is, well, something different.

Personally, I am not against using kevent for driver events/errors, but
the exact scope needs to be decided by the community.  You do need a
kevent, though.

	Robert Love


