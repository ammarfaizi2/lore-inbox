Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTJ2JRx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 04:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbTJ2JRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 04:17:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38922 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261932AbTJ2JRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 04:17:52 -0500
Date: Wed, 29 Oct 2003 09:17:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/BK] RESEND TRIVIAL fix run-together lines in /proc/tty/driver/serial
Message-ID: <20031029091748.A3681@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20031029031232.GA18071@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031029031232.GA18071@merlin.emma.line.org>; from matthias.andree@gmx.de on Wed, Oct 29, 2003 at 04:12:32AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 04:12:32AM +0100, Matthias Andree wrote:
> /proc/tty/driver/serial runs together lines for known UARTS when the
> user has no CAP_SYS_ADMIN capabilities. The patch below fixes this.
> Works and fixes the problem for me.
> GNU patch and BK send format below, or bk pull bk://129.217.163.1/linux-2.5/

I've merged this into my tree.  Thanks for the fix.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
