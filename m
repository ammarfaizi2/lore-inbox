Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVAYPss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVAYPss (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 10:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVAYPss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 10:48:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28346 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261973AbVAYPsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 10:48:46 -0500
Date: Tue, 25 Jan 2005 09:59:25 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 8xx 2.6.10-rc3 console_init()->con_init()->__alloc_bootmem() caus es "Oops: kernel access of bad area"
Message-ID: <20050125115925.GC19585@logos.cnet>
References: <313680C9A886D511A06000204840E1CF0A64758D@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <313680C9A886D511A06000204840E1CF0A64758D@whq-msgusr-02.pit.comms.marconi.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 09:30:49AM -0500, Povolotsky, Alexander wrote:
> I booting kernel on 8xx 2.6.10-rc3
> while trying to debug non-working console,
> I moved  console_init() call way down in __init start_kernel()
> and put indefinite while loop right after it -
> is it legtimate thing to do ?
> 
> Then I got soft reboot and was able to examine the content of the log buffer
> in the bootloader.
> I see that in a trace (function call sequence):
> 
> console_init()->con_init()->__alloc_bootmem() 
> 
> I am getting "Oops: kernel access of bad area"
> 
> I am looking for advise,

Hi Alexander,

I recommend using the linuxppc-2.5 BK tree for 8xx. Are you doing that?

The linuxppc-embedded list is a better place for discussion of such issues.

And about your problem, you need to get the full oops message, not only the 
beginning of it.

