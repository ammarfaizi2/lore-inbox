Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVLLIOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVLLIOE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 03:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVLLIOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 03:14:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61095 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751129AbVLLIOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 03:14:03 -0500
Date: Mon, 12 Dec 2005 00:13:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stefan Seyfried <seife@suse.de>
Cc: vojtech@suse.cz, dtor_core@ameritech.net, luming.yu@intel.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, len.brown@intel.com,
       bero@arklinux.org
Subject: Re: [git pull 02/14] Add Wistron driver
Message-Id: <20051212001315.0e2c64f1.akpm@osdl.org>
References: <20051211224059.GA28388@midnight.suse.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Seyfried <seife@suse.de> wrote:
>
> In article <20051211224059.GA28388@midnight.suse.cz> you wrote:
> > On Sun, Dec 11, 2005 at 01:10:13PM +0000, Bernhard Rosenkraenzer wrote:
> >> I think routing them to the input layer makes most sense because they are keys 
> >> like everything else -- of course hacking acpid to pass on ACPI key events to 
> >> Xorg via the XTest extension is not exactly hard, but that would break the 
> >> keys in text mode (who knows, maybe someone wants to map his mail key to 
> >> "mutt[RETURN]"?), and of course launching an application from acpid is a bit 
> >> hard (acpid runs as root --> need to figure out which user is pressed the 
> >> button, switch user IDs, find the correct X display if any, .....) if it's an 
> >> input event, solutions for the expected functionality already exist - e.g. 
> >> khotkeys.
> > 
> > You also can hack acpid to use uinput to feed the events back to the
> > input subsystem, but I agree with you that going there directly is
> > probably the best way to go.
> 
> pcc_acpi already does this successfully and is a pleasure to use.

That's not in the tree any more.   Did something replace it?
