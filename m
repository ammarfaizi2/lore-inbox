Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbTDNKgj (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 06:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbTDNKgj (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 06:36:39 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:40098 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262947AbTDNKgh (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 06:36:37 -0400
Date: Mon, 14 Apr 2003 11:47:57 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Nicholas Wourms <nwourms@myrealbox.com>, linux-kernel@vger.kernel.org
Subject: Re: Early boot oops with 2.5.67-bk(current) on a dual Athlon-MP [Asus A7M266-D] machine
Message-ID: <20030414104749.GA28179@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>,
	Nicholas Wourms <nwourms@myrealbox.com>,
	linux-kernel@vger.kernel.org
References: <3E99B9B4.8000304@myrealbox.com> <20030413165259.36fb0f97.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030413165259.36fb0f97.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 13, 2003 at 04:52:59PM -0700, Andrew Morton wrote:
 > > Attached is the oops (which results in a panic) when I 
 > > attempt to boot the lastest bk current on my machine.
 > The MCE code is using the workqueue infrastructure waaaaaaay earlier than it
 > is allowed to.  It looks like the timer went off before the workqueue
 > initialisation had been run.

Patch looks good to me, and cleans things up as an added bonus.

		Dave

