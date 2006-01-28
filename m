Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWA1V0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWA1V0c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 16:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWA1V0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 16:26:31 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:39688 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750758AbWA1V0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 16:26:31 -0500
Date: Sat, 28 Jan 2006 22:26:21 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] [x86] align per-cpu section to configured cache bytes
Message-ID: <20060128212621.GA10548@mars.ravnborg.org>
References: <20060127220242.13917.839.sendpatchset@tetsuo.zabbo.net> <20060127220247.13917.8544.sendpatchset@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127220247.13917.8544.sendpatchset@tetsuo.zabbo.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 02:02:47PM -0800, Zach Brown wrote:
> [x86] align per-cpu section to configured cache bytes
> 
> This matches the fix for a bug seen on x86-64.  Test booted on old hardware
> that had 32 byte cachelines to begin with.
> 
>   Signed-off-by: Zach Brown <zach.brown@oracle.com>

I've applied this verbatim.
The asm-generic part suggested in other mail was not straightforward due
to subtle differences and I have not yet my cross compile environment
running on this box.

	Sam
