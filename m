Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbVAQUDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVAQUDk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 15:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbVAQUDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 15:03:40 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:29639 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262861AbVAQUCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 15:02:54 -0500
Date: Mon, 17 Jan 2005 21:03:10 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Matthew Harrell 
	<mharrell-dated-1106423897.d1fc24@bittwiddlers.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Message-ID: <20050117200310.GA6973@ucw.cz>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org> <200501122242.51686.dtor_core@ameritech.net> <20050114230637.GA32061@bittwiddlers.com> <200501142031.10119.dtor_core@ameritech.net> <20050117195628.GA6704@ucw.cz> <20050117195815.GA22064@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117195815.GA22064@bittwiddlers.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 02:58:15PM -0500, Matthew Harrell wrote:
> : 
> : I expect the problem to be coming from the fact that the keyboard
> : controller uses ports 0x60 and 0x64, not 0x66 as ACPI tries to tell us
> : here.
> : 
> 
> Interesting - hadn't noticed that.  Is there an easy solution around it that
> doesn't entail turning off acpi?
 
The only one I see would be using "i8042.noacpi=1" on the kernel command
line.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
