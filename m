Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272141AbTHOWqy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 18:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272159AbTHOWqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 18:46:54 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:4035 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S272141AbTHOWqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 18:46:53 -0400
Date: Sat, 16 Aug 2003 00:46:52 +0200
From: Kurt Roeckx <Q@ping.be>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with framebuffer in 2.6.0-test3
Message-ID: <20030815224652.GA335@ping.be>
References: <20030815142008.GA22123@ping.be> <Pine.LNX.4.44.0308152301190.30952-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308152301190.30952-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 11:03:51PM +0100, James Simmons wrote:
> 
> Ah. You have a Voodoo 3 card. Please only us that driver. Also make sure 
> you have CONFIG_FRAMEBUFFER_CONSOLE set.

This used to work perfectly in 2.4.

I disabled CONFIG_FB_VGA16 and CONFIG_FB_VESA now I get:

  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x742cb): In function `tdfxfb_imageblit':
: undefined reference to `cfb_imageblit'
make: *** [.tmp_vmlinux1] Error 1


Kurt

