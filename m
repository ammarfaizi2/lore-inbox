Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273288AbTG3TP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273316AbTG3TP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:15:27 -0400
Received: from CPE-65-29-19-166.mn.rr.com ([65.29.19.166]:23688 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S273288AbTG3TPW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:15:22 -0400
Subject: Re: Buffer I/O error on device hde3, logical block 4429
From: Shawn <core@enodev.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1059585712.11341.24.camel@localhost>
References: <1059585712.11341.24.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059592520.11341.47.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 30 Jul 2003 14:15:20 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears Mike Galbraith has seen something similar in -vanilla.
http://www.ussg.iu.edu/hypermail/linux/kernel/0307.3/1987.html

Does anyone have any interest at all in pursuing this? Hopefully? I'm
glad to try and be the pig of Guinea. Kill piggy!

On Wed, 2003-07-30 at 12:21, Shawn wrote:
> I am running 2.6.0-test2-mm1, and upon boot have received a gift of many
> "Buffer I/O error on device hde3" messages in my log. After they quit,
> they never seem to come back.
> 
> I'd just like to know what might cause this? I see fs/buffer.c is
> telling me this, but I don't know what is failing.
> 
> One thing of note, I just upgraded my CPU from an Athlon XP 1800+ to a
> 2400+, and had to disable IO-APIC, and shut APIC off in my BIOS.
