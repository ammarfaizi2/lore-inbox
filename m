Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270327AbTHSLpv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 07:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270332AbTHSLpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 07:45:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6407 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270327AbTHSLpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 07:45:50 -0400
Date: Tue, 19 Aug 2003 12:45:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Narayan Desai <desai@mcs.anl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: weird pcmcia problem
Message-ID: <20030819124547.B18205@flint.arm.linux.org.uk>
Mail-Followup-To: Narayan Desai <desai@mcs.anl.gov>,
	linux-kernel@vger.kernel.org
References: <87u18efpsc.fsf@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87u18efpsc.fsf@mcs.anl.gov>; from desai@mcs.anl.gov on Mon, Aug 18, 2003 at 07:34:59PM -0500
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 07:34:59PM -0500, Narayan Desai wrote:
> Running 2.6.0-test3 (both with and without your recent yenta socket
> patches) pcmcia cards present during boot don't show up until they are
> removed and reinserted. Once reinserted, they work fine. This only
> seems to occur if yenta_socket is build into the kernel; if support is
> modular, cards appear to be recognized properly at boot time. I am
> running on a thinkpad t21.  Let me know if I can help with this
> problem in any way...  thanks

As a general thing, when people report this problem (or any other problem),
can they please include at least the following details please:

- make/model of machine
- type of cardbus bridge (from lspci)
- type of card (pcmcia or cardbus)
- make/model of card
- full kernel dmesg (including yenta, card services messages)
- cardmgr messages from system log

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

