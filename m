Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbTJVNJZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 09:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbTJVNJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 09:09:24 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:35596 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S263675AbTJVNJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 09:09:18 -0400
Date: Tue, 21 Oct 2003 20:53:26 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-mm1
Message-ID: <20031021185326.GA1558@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20031020185613.7d670975.akpm@osdl.org> <Pine.LNX.4.44.0310211846210.32738-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310211846210.32738-100000@phoenix.infradead.org>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Simmons <jsimmons@infradead.org>
Date: Tue, Oct 21, 2003 at 06:47:41PM +0100
> 
> Okay I see people are having alot of problems in the -mm tree. I don't 
> have any problems but I'm working against Linus tree. Could people try the 
> patch against 2.6.0-test8 and tell me if they still have the same results. 
> I have a new patch here:
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
2.6.0-test8 + this patch boots perfectly here:

kernel /boot/vmlinuz-260test8fb root=/dev/md3 video=matroxfb:xres:1600,yres:1360,depth:16,pixclock:4116,left:304,right:64,upper:46,lower:1,hslen:192,vslen:3,fv:90,hwcursor=off hdd=scsi atkbd_softrepeat=1

This configuration didn't boot in 2.6.0-test8-mm1 (screen stayed in
80x25 VGA mode and it crashed before the mode-switch).

HTH,
Jurriaan
-- 
Life's really a chocolate box - some do without - others have plenty.
	Skyclad - Inequality Street
Debian (Unstable) GNU/Linux 2.6.0-test8 4276 bogomips 0.39 0.17
