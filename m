Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbTFHGbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 02:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbTFHGbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 02:31:24 -0400
Received: from pan.togami.com ([66.139.75.105]:54430 "EHLO pan.mplug.org")
	by vger.kernel.org with ESMTP id S264643AbTFHGbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 02:31:16 -0400
Subject: Re: memtest86 on the opteron
From: Warren Togami <warren@togami.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <p73of195bj1.fsf@oldwotan.suse.de>
References: <20030607202725.22992.qmail@email.com.suse.lists.linux.kernel>
	 <20030607214356.GF667@elf.ucw.cz.suse.lists.linux.kernel>
	 <1055040745.27939.3.camel@camp4.serpentine.com.suse.lists.linux.kernel>
	 <p73of195bj1.fsf@oldwotan.suse.de>
Content-Type: text/plain
Message-Id: <1055054691.18692.13.camel@laptop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (1.3.92-1) (Preview Release)
Date: 07 Jun 2003 20:44:51 -1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-07 at 20:27, Andi Kleen wrote:
> Bryan O'Sullivan <bos@serpentine.com> writes:
> 
> > On Sat, 2003-06-07 at 14:43, Pavel Machek wrote:
> > 
> > > Well, as opteron is i386-compatible, you should be able to simply use
> > > i386 memtest...
> > 
> > It doesn't work.  Crashes and reboots the system shortly after it
> > starts.  The serial console support appears to have bit-rotted, too, so
> > I've not been able to capture an output screen to diagnose the problem.
> 
> The problem is the CPUID handling in memtest86. It does not expect
> the 15 model number on AMD systems. Someone did a patch for it, but
> I don't remember where they put it. Anyways should be easy to fix again
> given the source.
> 

If you find the patch I am interested in it.  Please CC me.

I am guessing that a normal 32bit compiled memtest86 wont be able to
test beyond 4GB of RAM on AMD64?

Warren

