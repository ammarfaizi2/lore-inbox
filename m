Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312401AbSDNSV4>; Sun, 14 Apr 2002 14:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312408AbSDNSVy>; Sun, 14 Apr 2002 14:21:54 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:10340 "EHLO
	server0011.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S312401AbSDNSVx>; Sun, 14 Apr 2002 14:21:53 -0400
Date: Sun, 14 Apr 2002 19:25:32 +0100
From: Ian Molton <spyro@armlinux.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb-uhci *BUG*
Message-Id: <20020414192532.65afcfae.spyro@armlinux.org>
In-Reply-To: <20020414164355.GA18040@kroah.com>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.7.4cvs5 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH Awoke this dragon, who will now respond:

> On Sun, Apr 14, 2002 at 06:32:47PM +0100, Ian Molton wrote:
> > 
> > > What devices do you have plugged in?
> > 
> > one alcatel usb speedtouch ADSL modem, using the 'user mode' driver.
> 
> Ah, please try using the patch below from David Brownell to fix this
> problem.  I've already applied this to my trees, and will get pushed to
> the main kernels soon.
> 
> Let me know if this helps or not.

apparently not. first time it booted, it oopsed (not recorded, sorry).
second time, it hit the BUG() again. same backtrace.

I built USB all as modules, in case thats relevant.
