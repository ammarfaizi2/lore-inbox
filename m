Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbTHYJkj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 05:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbTHYJkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 05:40:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39428 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261486AbTHYJki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 05:40:38 -0400
Date: Mon, 25 Aug 2003 10:40:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Mario Mikocevic <mozgy@hinet.hr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS 2.6.0-test4 repeatable
Message-ID: <20030825104035.B30952@flint.arm.linux.org.uk>
Mail-Followup-To: Mario Mikocevic <mozgy@hinet.hr>,
	linux-kernel@vger.kernel.org
References: <20030825091846.GA15017@danielle.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030825091846.GA15017@danielle.hinet.hr>; from mozgy@hinet.hr on Mon, Aug 25, 2003 at 11:18:46AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 11:18:46AM +0200, Mario Mikocevic wrote:
> IBM Thinkpad R40 with 2.6.0-test4, alsa compiled as module.
> If I plug in D-link DWL-650+ (_just_ a plug in a slot) and _then_
> modprobe snd-intel8x0 within seconds this oops barfs on me.

After asking akpm what an "invalid operand" on x86 means, he says its
a BUG() statement.  So, can you please supply both the ksymoops'd
*and* the raw undecoded kernel messages.  Apparantly ksymoops cuts off
the lines which indicate that it was a bug and where the BUG() statement
was.

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

