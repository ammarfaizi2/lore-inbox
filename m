Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTKHAa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTKGWGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:06:35 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56533 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264031AbTKGKGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 05:06:11 -0500
Date: Fri, 7 Nov 2003 11:06:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: test9: suspend no go
Message-ID: <20031107100609.GA5088@elf.ucw.cz>
References: <3F9BCF7A.7000403@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9BCF7A.7000403@portrix.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> A little contribution to the ongoing suspend saga. This is a Sony Vaio
> SRX51P Laptop (P3 Mobile CPU, i820 chipset).


Few tips:

If you want to trick swsusp/S3 into working, you might want to try:

* go with minimal config, turn off drivers like USB you don't really
need

* use ext2. At least it has working fsck. [If something seemes to go
  wrong, force fsck when you have a chance]

* turn off modules

* use vga text console, shut down X

* try running as few processes as possible, preferably go from single
use mode

When you make it work, try to find out what exactly was it that broke
suspend, and preferably fix that.


								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
