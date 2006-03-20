Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWCTVmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWCTVmy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWCTVmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:42:54 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:46542 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964988AbWCTVmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:42:53 -0500
Date: Mon, 20 Mar 2006 22:42:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Schwab <schwab@suse.de>
cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: lstat returns bogus values.
In-Reply-To: <jed5ggx39x.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.61.0603202242240.11933@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0603201312320.23345@chaos.analogic.com>
 <jed5ggx39x.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The "kernelly-corrected" stuff should have been returned by lstat()
>
>What should lstat return for a cdrom device node that has no medium?
>Should "ls -l /dev/cdrom" block until you have inserted a CD?
>
Given that /dev/cdrom is a symlink on many systems, it should just 
dereference the symlink :)


Jan Engelhardt
-- 
