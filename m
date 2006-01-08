Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161154AbWAHTlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbWAHTlF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbWAHTlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:41:05 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:8102 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1161154AbWAHTlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:41:04 -0500
From: Grant Coady <gcoady@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: vherva@vianova.fi, linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Date: Mon, 09 Jan 2006 06:40:57 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <6cq2s1d3glnj56pcrqlj84s8ltilmo6jfp@4ax.com>
References: <20060105045212.GA15789@redhat.com> <Pine.LNX.4.61.0601050907510.10161@yvahk01.tjqt.qr> <20060105103339.GG20809@redhat.com> <20060108133822.GD31624@vianova.fi> <20060108055322.18d4236e.rdunlap@xenotime.net>
In-Reply-To: <20060108055322.18d4236e.rdunlap@xenotime.net>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006 05:53:22 -0800, "Randy.Dunlap" <rdunlap@xenotime.net> wrote:

>On Sun, 8 Jan 2006 15:38:22 +0200 Ville Herva wrote:
>
>> On Thu, Jan 05, 2006 at 05:33:39AM -0500, you [Dave Jones] wrote:
>> > 
>> > If I had any faith in the sturdyness of the floppy driver, I'd
>> > recommend someone looked into a 'dump oops to floppy' patch, but
>> > it too relies on a large part of the system being in a sane
>> > enough state to write blocks out to disk.
>> 
>> I believe kmsgdump (http://www.xenotime.net/linux/kmsgdump/) uses its own
>> minimal 16-bit floppy driver to save the oops dump. 
>
>It just switches to real mode and uses BIOS calls.

So would it be viable to take over the screen in similar fashion?

Set it to 80x50 in BIOS and dump there --> call it the Penguin Oops 
screen, or Poops for short :o)

Grant.
