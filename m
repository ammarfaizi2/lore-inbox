Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbTHWLkz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 07:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbTHWLkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 07:40:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63503 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262619AbTHWLky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 07:40:54 -0400
Date: Sat, 23 Aug 2003 12:40:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: dahinds@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0t4 - no pcmcia
Message-ID: <20030823124050.D25729@flint.arm.linux.org.uk>
Mail-Followup-To: dahinds@users.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20030823112446.GA3341@iain-vaio-fx405>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030823112446.GA3341@iain-vaio-fx405>; from ibroadfo@cis.strath.ac.uk on Sat, Aug 23, 2003 at 12:24:46PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 12:24:46PM +0100, iain d broadfoot wrote:
> After booting 2.6.0-test4, i get the following error when trying to
> initialise cardmgr:
> 
> orinoco_cs: RequestIRQ: Resource in use
> 
> I couldn't see anything changed in the config that could have caused
> this.

Please check that you have: CONFIG_ISA=y

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

