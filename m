Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266453AbUBFEdc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 23:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266462AbUBFEdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 23:33:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:22914 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266453AbUBFEdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 23:33:18 -0500
Date: Thu, 5 Feb 2004 20:30:41 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Greg Norris <haphazard@kc.rr.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb mouse/keyboard problems under 2.6.2
Message-Id: <20040205203041.416ecf2a.rddunlap@osdl.org>
In-Reply-To: <20040206011531.GA2084@yggdrasil.localdomain>
References: <20040204174748.GA27554@yggdrasil.localdomain>
	<20040205142155.GA606@ucw.cz>
	<20040205160226.GA13471@yggdrasil.localdomain>
	<20040205230304.GA2195@yggdrasil.localdomain>
	<20040206011531.GA2084@yggdrasil.localdomain>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Feb 2004 19:15:31 -0600 Greg Norris <haphazard@kc.rr.com> wrote:

| On Thu, Feb 05, 2004 at 05:03:04PM -0600, Greg Norris wrote:
| > Here's the output from dmesg, after rebuilding with CONFIG_USB_DEBUG
| > enabled.  It doesn't seem to be producing any output from after the
| > initialization completed (and the problem has recurred several times
| > since then), so please let me know if I should be going about this
| > differently.
| > 
| > Thanx!
| 
| The problem appears to have been introduced in 2.6.2-rc2.  Can anyone
| tell me how to find the individual patches which were added between
| -rc1 and -rc2?  I can diff the trees easily enough, of course, but it
| would be much easier if I had a collection of discrete patches to work
| with.

I don't see an easy way to see all of those changesets.
Changesets used to be available at
  http://www.kernel.org/pub/linux/kernel/v2.6/testing/cset/
but what's there now is only for after 2.6.2 was released.

You can also see the changesets listed at
  http://linux.bkbits.net:8080/linux-2.5/ChangeSet@-4w?nav=index.html
(that's all changesets for the last 4 weeks) and then just look
at all of the changes between the v2.6.2-rc1 and v2.6.2-rc2 tags
(which are highlighted in yellow).

--
~Randy
