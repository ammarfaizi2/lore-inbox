Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265843AbUFOScK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265843AbUFOScK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265839AbUFOSbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:31:31 -0400
Received: from holomorphy.com ([207.189.100.168]:32680 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265811AbUFOSbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:31:22 -0400
Date: Tue, 15 Jun 2004 11:30:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Micah Anderson <micah@riseup.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.6 grinds to a halt with moderate I/O
Message-ID: <20040615183018.GC1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Micah Anderson <micah@riseup.net>, linux-kernel@vger.kernel.org
References: <20040615154745.GD22650@riseup.net> <20040615160049.GX1444@holomorphy.com> <20040615181908.GC22650@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615181908.GC22650@riseup.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Thanks for the bugreport. I'm going to file this in the Debian BTS
>> after I get the FPU fixes out. Could you send along a dmesg
>> (/var/log/dmesg on Debian) and /proc/meminfo and /proc/cpuinfo at some
>> point when you can log into the box? I'll also try to reproduce this.

On Tue, Jun 15, 2004 at 01:19:08PM -0500, Micah Anderson wrote:
> I am not sure why this would be filed in the Debian BTS, yes the
> underlying OS is Debian, but this is not a Debian Kernel, it is a
> vanilla 2.6.6 kernel that I compiled by hand.

The debian kernel team is migrating Debian's 2.6 as close to mainline
as is possible within policy guidelines, so it'll be applicable to it
hopefully in the next 24 hours.

On Tue, Jun 15, 2004 at 01:19:08PM -0500, Micah Anderson wrote:
> Please find attached the dmesg and the /proc/meminfo, the
> /proc/cpuinfo was already included in the original email.

Okay, thanks. I'll do some testing of copying large files shortly.


-- wli
