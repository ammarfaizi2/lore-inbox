Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbTHaMiu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 08:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTHaMiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 08:38:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53521 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261362AbTHaMit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 08:38:49 -0400
Date: Sun, 31 Aug 2003 13:38:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Same problem with pcmcia in 2.4.22 as in 2.6.0-test4
Message-ID: <20030831133846.C3017@flint.arm.linux.org.uk>
Mail-Followup-To: kernel <linux-kernel@vger.kernel.org>
References: <1061936739.10642.6.camel@garaged.fis.unam.mx> <20030826223405.GA2746@iain-vaio-fx405> <20030831121019.GB22771@iain-vaio-fx405>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030831121019.GB22771@iain-vaio-fx405>; from ibroadfo@cis.strath.ac.uk on Sun, Aug 31, 2003 at 01:10:20PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 01:10:20PM +0100, iain d broadfoot wrote:
> Hallo again,
> 
> Just wondering if anyone has any insights into what's going wrong with
> my pcmcia in both 2.4.22 and 2.6.0-test4.
> 
> orinoco_cs: RequestIRQ: Resource in use
> 
> is the error I get on inserting my wireless card.

There's a patch on pcmcia.arm.linux.org.uk for 2.6.0-test4 which gets
some more information about what went wrong.  Could you apply it and
report the kernel messages please?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

