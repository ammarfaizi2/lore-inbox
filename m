Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTIFVoN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 17:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTIFVoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 17:44:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14087 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262041AbTIFVoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 17:44:12 -0400
Date: Sat, 6 Sep 2003 22:44:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Paul Dickson <dickson@permanentmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Missing cardbus label in /proc/interrupts
Message-ID: <20030906224407.E29417@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Dickson <dickson@permanentmail.com>,
	linux-kernel@vger.kernel.org
References: <20030815161819.4ff4ad0a.dickson@permanentmail.com> <20030827030623.7c0a4d65.dickson@permanentmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030827030623.7c0a4d65.dickson@permanentmail.com>; from dickson@permanentmail.com on Wed, Aug 27, 2003 at 03:06:23AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 03:06:23AM -0700, Paul Dickson wrote:
> In 2.6.0-test4, /proc/interrupts:
> 
>  11:     195758          XT-PIC  uhci-hcd, 0000:00:04.0, 0000:00:04.1, eth0
> 
> The labels are no longer missing, but is this the ultimate designation for
> a cardbus bridge?

This should be fixed in 2.6.0-test4-bkcurr as of tonight (they're now
called "yenta".)

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
