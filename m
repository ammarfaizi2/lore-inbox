Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbTI0Ibj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 04:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbTI0Ibj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 04:31:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22532 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262406AbTI0Ibi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 04:31:38 -0400
Date: Sat, 27 Sep 2003 09:31:31 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-pcmcia@lists.infradead.org
Subject: Re: [CFT] Socket quiescing changes
Message-ID: <20030927093131.A3440@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-pcmcia@lists.infradead.org
References: <20030922195805.E31823@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030922195805.E31823@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Mon, Sep 22, 2003 at 07:58:05PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 07:58:05PM +0100, Russell King wrote:
> This patch changes the way in which we turn off power to PCMCIA sockets.
> We have traditionally relied on the socket drivers "init" method to
> shut down the power to the socket by calling its own "set_socket" function.

I've heard nothing back from this patch, so I'm going to assume that
it works for everyone, and therefore it'll be committed later today.

If anyone has any objections to it, or found that it doesn't work on
their machine, it would be preferable that they spoke up in the next
couple of hours.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
