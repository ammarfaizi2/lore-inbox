Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbULXRVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbULXRVx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 12:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbULXRVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 12:21:53 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:21520 "EHLO
	smtp-vbr8.xs4all.nl") by vger.kernel.org with ESMTP id S261414AbULXRVv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 12:21:51 -0500
Date: Fri, 24 Dec 2004 18:21:27 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: "James D. Freels" <freelsjd@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.28, 64GB highmem, keyboard conflict on Tyan MB
Message-ID: <20041224172127.GA21256@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <1103903479.4912.15.camel@pcp483125pcs.oakrdg01.tn.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103903479.4912.15.camel@pcp483125pcs.oakrdg01.tn.comcast.net>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James D. Freels <freelsjd@comcast.net>
Date: Fri, Dec 24, 2004 at 10:51:19AM -0500
> I have two dual-processor Xeon machines set up in a similar manner.
> Both have 4GB of main memory.  Machine A utilizes an Intel MB.  In order
> to take advantage of all the memory, the 64GB highmem option must be
> selected.  If I select only the 4GB option, not quite all of the memory
> is used.  Everything works fine on this machine.
> 
> Machine B utilizes a Tyan MB.  If I select the 4GB highmem option,
> everything works fine except not all the memory is available (only
> 3616824K shows from "top").  Now if I try to select the 64GB highmem
> option similar to Machine A (after recompiling the kernel and trying to
> boot), the machine will not boot and the error message displayed to the
> console says "missing keyboard".
> 
> I have a true ps/2 keyboard on both machines as well as ps/2 mouse.
> 
> How can I correct this problem ?  Will I need to change to a USB
> keyboard/mouse for this MB ?
> 
I have no idea. But I can suggest, that in order to get meaningful
hints, you may want to mention exactly what kind of motherboards (and
bios levels) you're talking about, along with the top 50 lines of dmesg
output from both the 4 Gb and the 64 Gb kernel on the Tyan MB.

Nobody will know that 'a Tyan MB' is, unless it's the Illuminati and
you wouldn't want those on to you, right?

Jurriaan
-- 
Whoever thought that one up should have his head examined. Bloody minstrels...
	Simon R Green - Blue Moon Rising
Debian (Unstable) GNU/Linux 2.6.10-rc3 2x6078 bogomips load 0.13
