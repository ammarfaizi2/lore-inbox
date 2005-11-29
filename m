Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVK2Vdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVK2Vdm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 16:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVK2Vdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 16:33:42 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:41152 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932422AbVK2Vdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 16:33:41 -0500
Date: Tue, 29 Nov 2005 22:36:56 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc3
Message-ID: <20051129213656.GA8706@aitel.hist.no>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 08:11:35PM -0800, Linus Torvalds wrote:
> 
> I just pushed 2.6.15-rc3 out there, and here are both the shortlog and 
> diffstats appended.
> 
This one did not mount root.  I got:

Can't open root dev "831" or unknown block(8,49)
Please append a correct root= boot option
unable to mount root fs from block(8,49)



Now 2.6.14 works with exactl�y the same lilo.con,
where I have root=/dev/sdd1  (SATA drive)

The only changes from the 2.6.14 .config were a different
framebuffer font for the console (which worked fine) and
a change from voluntary preempt to fully preemptible in the
hope of running flash games and niced compiles together.


Helge Hafting



