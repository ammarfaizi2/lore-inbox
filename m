Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272278AbTHIIPc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 04:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272284AbTHIIPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 04:15:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42254 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272278AbTHIIP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 04:15:29 -0400
Date: Sat, 9 Aug 2003 09:15:24 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] More PCI fixes for 2.6.0-test2
Message-ID: <20030809091524.A13885@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20030809003036.GA3163@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030809003036.GA3163@kroah.com>; from greg@kroah.com on Fri, Aug 08, 2003 at 05:30:36PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 05:30:36PM -0700, Greg KH wrote:
> Here are a few more fixes for the PCI core code for 2.6.0-test2-bk.
> I've removed all of the struct device.name usages as that field is about
> to go away, and there is a fix from Ivan in here too.

When was that decided?  I don't remember seeing any discussion, and since
it affects more than PCI... Seems like a backwards step to me.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

