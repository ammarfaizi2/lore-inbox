Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVDEDOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVDEDOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 23:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVDEDOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 23:14:48 -0400
Received: from orb.pobox.com ([207.8.226.5]:26559 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261553AbVDEDO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 23:14:28 -0400
Date: Mon, 4 Apr 2005 20:14:23 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Bob Gill <gillb4@telusplanet.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ... no drivers for IEEE1394 product 0x/0x/0x in kernel 2.6.12-rc1-bk6
Message-ID: <20050405031423.GA10733@ip68-4-98-123.oc.oc.cox.net>
References: <1112667776.6675.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112667776.6675.1.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 08:22:56PM -0600, Bob Gill wrote:
> Hi.  I recently built 2.6.12-rc1-bk6.  The kernel seems to be tripping
> over sbp2.  The error messages keep right on rolling till I hit the
> reboot button (I let it run for more than 90 seconds last time).
> 2.6.11.6 builds/runs without any problems.
[snip]

I was having the same problem on a system of mine too, but it went away
after I disabled CONFIG_DEVFS_FS. You didn't include enough of your
.config for me to be able to tell if that is at all relevant in your
case however.

-Barry K. Nathan <barryn@pobox.com>
