Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUD0GCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUD0GCF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 02:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUD0GCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 02:02:05 -0400
Received: from [194.89.250.117] ([194.89.250.117]:59531 "EHLO
	kimputer.holviala.com") by vger.kernel.org with ESMTP
	id S263784AbUD0GCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 02:02:02 -0400
From: Kim Holviala <kim@holviala.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
Date: Tue, 27 Apr 2004 09:02:01 +0300
User-Agent: KMail/1.6.1
References: <s5g8ygi4l3q.fsf@patl=users.sf.net>
In-Reply-To: <s5g8ygi4l3q.fsf@patl=users.sf.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404270902.01011.kim@holviala.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 April 2004 22:10, Patrick J. LoPresti wrote:

> For example, I invoke "modprobe hid" to make my USB keyboard work.
> This loads the module and exits immediately, causing my script to
> proceed, before the USB keyboard is probed and ready.
>
> I want to wait until the driver is finished initializing (i.e., a USB
> keyboard is either found or not found) before my script continues.
> How can I do that?
>
> I seem to be having similar problems loading certain other modules
> (PCMCIA, Ethernet), but hid.o is the only one for which I have not
> found a convenient workaround.

Well, this isn't what you wanted to hear :-) but I use sleep on my 
PCMCIA/nfsroot boot initrds. Sleeping for 3-5 seconds is enough for the 
modules to load properly and it won't slow down the boot too much either...




Kim
