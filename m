Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268590AbUIGU1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268590AbUIGU1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUIGU1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 16:27:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13831 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268650AbUIGUQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 16:16:39 -0400
Date: Tue, 7 Sep 2004 21:16:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The Serial Layer
Message-ID: <20040907211634.D15295@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1094582980.9750.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1094582980.9750.12.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Tue, Sep 07, 2004 at 07:49:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 07:49:42PM +0100, Alan Cox wrote:
> Is anyone currently looking at fixing this before I start applying
> extreme violence ? In particular to start trying to do something about
> the races in TIOCSTI, line discipline setting, hangup v receive, drivers
> abusing the API and calling ldisc.receive_buf direct ?

I'm certainly not delving into the TTY layers itself - there's far
too many drivers which would break horribly if I were to do that.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
