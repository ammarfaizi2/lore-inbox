Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263359AbTH0M7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 08:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbTH0M7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 08:59:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11274 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263359AbTH0M7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 08:59:43 -0400
Date: Wed, 27 Aug 2003 13:59:40 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Tom Marshall <tommy@home.tig-grr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems with PCMCIA (Texas Instruments PCI1410)
Message-ID: <20030827135940.A31850@flint.arm.linux.org.uk>
Mail-Followup-To: Daniel Ritz <daniel.ritz@gmx.ch>,
	Tom Marshall <tommy@home.tig-grr.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200308270056.33190.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308270056.33190.daniel.ritz@gmx.ch>; from daniel.ritz@gmx.ch on Wed, Aug 27, 2003 at 12:56:33AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 12:56:33AM +0200, Daniel Ritz wrote:
> can you please retest with -test4 and russell's yenta patches?
> http://patches.arm.linux.org.uk/pcmcia/yenta-20030817.tar

I've just created http://pcmcia.arm.linux.org.uk/ to document the
currently known problems and to contain patches for them.

> if that doesn't work out: could you please add these lines to in
> yenta_socket.c?

What seems to happen is that some peoples cardbus bridges don't report
the "card insert" interrupt, or they do and the socket status does not
report that the card is inserted.

I'll review all the reports thus far this afternoon and expand the
problem description on the website.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

