Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUDJBwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 21:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbUDJBwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 21:52:40 -0400
Received: from memebeam.org ([212.13.199.71]:15878 "EHLO jvb.vm.bytemark.co.uk")
	by vger.kernel.org with ESMTP id S261787AbUDJBwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 21:52:39 -0400
Message-ID: <4077535D.6020403@neggie.net>
Date: Fri, 09 Apr 2004 21:52:29 -0400
From: John Belmonte <john@neggie.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@hp.com>
CC: acpi-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: [PATCH] filling in ACPI method access via sysfs namespace
References: <1081453741.3398.77.camel@patsy.fc.hp.com> <1081549317.2694.25.camel@patsy.fc.hp.com>
In-Reply-To: <1081549317.2694.25.camel@patsy.fc.hp.com>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Williamson wrote:
>    Here's another approach that's far less ugly than the last and is
> much more powerful.  The code is a little over half the size as a
> bonus.  Rather than specifically poking for certain methods and exposing
> them, this patch exposes everything.  The down side is that all reading
> and writing of the files need to use binary acpi data structures.  This
> interface certainly provides "shoot yourself in the foot" potential, but
> the access to the namespace from userspace is hard to beat.  Any
> thoughts on this approach versus the last?  This interface and a simple
> set of libraries to go along with it has a lot of potential.  Thanks,

The limitation of this interface is that it's not able to call an ACPI 
method with some arguments and get the return value, correct?

-John


-- 
http:// if  ile.org/
