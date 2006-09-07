Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWIHNoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWIHNoT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 09:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWIHNoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 09:44:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20230 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751115AbWIHNoT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 09:44:19 -0400
Date: Thu, 7 Sep 2006 19:33:33 +0000
From: Pavel Machek <pavel@suse.cz>
To: Eric Sandall <eric@sandall.us>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Suspend to ram with 2.6 kernels
Message-ID: <20060907193333.GI8793@ucw.cz>
References: <44FF8586.8090800@sandall.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FF8586.8090800@sandall.us>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-09-06 19:35:50, Eric Sandall wrote:
> Hello LKML,
> 
> I am having a problem with suspend-to-ram (have been for a while, but
> suspend-to-disk has been working fine for me, so I never really bothered
> to report it until now).
> 
> Suspend-to-disk and resuming from it works fine (using `echo -n disk >
> /sys/power/state`).
> 
> Suspend-to-ram works fine (using `echo -n mem > /sys/power/state`), but
> resuming does not. When I lift up the lid of my laptop (Dell Inspiron
> 5100) it seems to power back up (the power light changes from blinking
> to solid), but my screen stays blank and keys such as capslock do not
> toggle their LED.

See suspend.sf.net, use provided s2ram program.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
