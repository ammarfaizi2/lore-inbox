Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbTFOR5j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTFOR5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:57:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47884 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262494AbTFOR5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:57:37 -0400
Date: Sun, 15 Jun 2003 19:11:25 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jaakko Niemi <liiwi@lonesom.pp.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 go boom
Message-ID: <20030615191125.I5417@flint.arm.linux.org.uk>
Mail-Followup-To: Jaakko Niemi <liiwi@lonesom.pp.fi>,
	linux-kernel@vger.kernel.org
References: <87isr7cjra.fsf@jumper.lonesom.pp.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87isr7cjra.fsf@jumper.lonesom.pp.fi>; from liiwi@lonesom.pp.fi on Sun, Jun 15, 2003 at 08:50:49PM +0300
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 08:50:49PM +0300, Jaakko Niemi wrote:
>  I seem to be able to reproduce crash with 2.7.70-bk and .71.
>  First, I tried getting dlink dwl-650 wlan card up on my thinkpad
>  570e, but orinoco_cs does not seem to want to even look at it.
>  (any ideas what's the deal with that, btw?) 

What happens if you plug in your cardbus card before the dlink wlan card?
If that doesn't work, please repeat your procedure to cause the oops.

In either case, could you send the output of lspci -vv at the
following points:

- directly after boot
- after you insert the cardbus card
- after you remove it
- after you re-insert (and get the oops)

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

