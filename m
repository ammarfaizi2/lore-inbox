Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbTIMTHA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 15:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTIMTG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 15:06:59 -0400
Received: from evil.netppl.fi ([195.242.209.201]:63665 "EHLO evil.netppl.fi")
	by vger.kernel.org with ESMTP id S262168AbTIMTGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 15:06:19 -0400
Date: Sat, 13 Sep 2003 22:06:11 +0300
From: Pekka Pietikainen <pp@netppl.fi>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Another keyboard woes with 2.6.0...
Message-ID: <20030913190611.GA16185@netppl.fi>
References: <20030912165044.GA14440@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20030912165044.GA14440@vana.vc.cvut.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 06:50:44PM +0200, Petr Vandrovec wrote:
> Hi Vojtech,
> keyboard. 2.4.x kernel works without problem, but when 2.6.0
> starts, immediately after input device driver is initialized it starts
> thinking that F7 key is held down, and it stays that way until
> I hit some other key to stop autorepeat... What debugging I
> can do for you to get rid of screen full of '^[[18~' ? /bin/login
> continuously complains about username being too long :-(
Hi

I wonder if the bug I'm seeing, http://bugme.osdl.org/show_bug.cgi?id=1121
is related to this at all. Basically if a key is pressed down
when the input gets passed on from the boot-up compatibility mode 
to the full USB stuff it gets stuck permanently.

-- 
Pekka Pietikainen




