Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTFQJl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 05:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbTFQJl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 05:41:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61454 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261561AbTFQJl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 05:41:56 -0400
Date: Tue, 17 Jun 2003 10:55:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: bvermeul@blackstar.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with PCMCIA/Orinoco
Message-ID: <20030617105544.D25452@flint.arm.linux.org.uk>
Mail-Followup-To: bvermeul@blackstar.nl, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0306171123540.1854-100000@blackstar.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0306171123540.1854-100000@blackstar.nl>; from bvermeul@blackstar.nl on Tue, Jun 17, 2003 at 11:29:00AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 11:29:00AM +0200, bvermeul@blackstar.nl wrote:
> I'm having some problems with 2.5.71 (latest bk yesterday I believe).
> All works well (pcmcia works as advertised, with one tiny blip on
> the horizon), except when I want to reboot, when I get the following
> message:
> 
> unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> 
> The net device is an Orinoco mini-pci card (eg, cardbus minipci interface 
> with built-in orinoco card), and it is down.
> 
> I'm not sure what causes this, and it's started somewhere in 2.5.70 bk.

I believe this is a netdevice problem and isn't anything to do with
PCMCIA or Cardbus.  If the net people would like to confirm this, it'd
be most helpful.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

