Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266540AbUAWGss (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266520AbUAWGq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:46:56 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:30695 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S266528AbUAWGos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:44:48 -0500
Date: Thu, 22 Jan 2004 22:44:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Tom Barnes-Lawrence <tomble@usermail.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE compilation(etc) errors
Message-ID: <235080000.1074840289@[10.10.2.4]>
In-Reply-To: <20040123042135.GA834@darius>
References: <20040123042135.GA834@darius>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So: SCSI, my adapter, and sd are compiled in, and (the first
> attempt, at least) IDE, and everything IDE related I built
> as *modules*. When I did make modules_install, it churned
> out a lot of warnings about various functions not being found
> for the modules. I assumed they would be found later.
> 
> Then, when I rebooted with the new kernel, sure enough, I found
> *no* IDE related kernel module I could load that didn't have
> unresolved symbols. Perhaps there was supposed to be some
> weird invocation of modprobe or insmod to load them all at
> once or something, but if so, news to me.

You probably want to try 2.6.1-mm5, it allegedly fixes those problems.

M.

