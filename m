Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTGKOx1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTGKOx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:53:27 -0400
Received: from raq465.uk2net.com ([213.239.56.46]:30729 "EHLO
	mail.truemesh.com") by vger.kernel.org with ESMTP id S262710AbTGKOxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:53:22 -0400
Date: Fri, 11 Jul 2003 16:02:21 +0100
From: Paul Nasrat <pauln@truemesh.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711150220.GG28359@raq465.uk2net.com>
Mail-Followup-To: Paul Nasrat <pauln@truemesh.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030711140219.GB16433@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711140219.GB16433@suse.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 03:02:19PM +0100, Dave Jones wrote:
 
> Known gotchas.
> ~~~~~~~~~~~~~~
> Certain known bugs are being reported over and over. Here are the
> workarounds.
> - Blank screen after decompressing kernel?
>   Make sure your .config has
>   CONFIG_INPUT=y, CONFIG_VT=y, CONFIG_VGA_CONSOLE=y and CONFIG_VT_CONSOLE=y
>   A lot of people have discovered that taking their .config from 2.4 and
>   running make oldconfig to pick up new options leads to problems, notably
>   with CONFIG_VT not being set.

You might want to mention the synaptics touchpad driver/event for
XFree86, as I'm sure that will be a FAQ amongst laptop users

http://w1.894.telia.com/~u89404340/touchpad/

Paul
