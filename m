Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbUDYHdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUDYHdJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 03:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUDYHdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 03:33:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48905 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261704AbUDYHdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 03:33:06 -0400
Date: Sun, 25 Apr 2004 08:33:02 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Jason Cox <steel300@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: Change number of tty devices
Message-ID: <20040425083302.A18033@flint.arm.linux.org.uk>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	Jason Cox <steel300@gentoo.org>, linux-kernel@vger.kernel.org
References: <20040422093302.B19797@flint.arm.linux.org.uk> <Pine.LNX.4.44.0404250414330.15965-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0404250414330.15965-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Sun, Apr 25, 2004 at 04:15:57AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2004 at 04:15:57AM +0100, James Simmons wrote:
> 
> > On Thu, Apr 22, 2004 at 02:24:06AM +0000, Jason Cox wrote:
> > > > When the kernel supports multi-desktop systems we will have to deal
> > > > with the serial and VT issue. Most likely the serial tty drivers will
> > > > be given a different major number. 
> > > 
> > > Why isn't this done now?
> > 
> > It's a API change and requires a flag day "everyone update their
> > filesystem."  Especially in a stable kernel series.
> 
> By the time 2.7.X comes around everyone should be using udev. That should 
> settle any problems. 

I have my doubts about that first statement.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
