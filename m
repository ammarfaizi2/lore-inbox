Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbTELWVc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTELWVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:21:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39941 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262239AbTELWV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:21:28 -0400
Date: Mon, 12 May 2003 23:31:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Fulghum <paulkf@microgate.com>,
       David Hinds <dahinds@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
Message-ID: <20030512233151.B17227@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Paul Fulghum <paulkf@microgate.com>,
	David Hinds <dahinds@users.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1052775331.1995.49.camel@diemos> <1052773631.31825.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052773631.31825.18.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, May 12, 2003 at 10:07:13PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 10:07:13PM +0100, Alan Cox wrote:
> On Llu, 2003-05-12 at 22:35, Paul Fulghum wrote:
> > The 2.5.X PCMCIA kernel support seems to have a problem
> > with drivers/pcmcia/rsrc_mgr.c in function undo_irq().
> 
> Does this still happen with all the patches Russell King posted
> that everyone else is ignoring ?

I'm in the process of putting the patch in my outgoing patch queue
for Linus, otherwise we're not going to make any forward progress.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

