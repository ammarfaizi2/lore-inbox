Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266017AbUAKXMD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 18:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUAKXMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 18:12:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55311 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266017AbUAKXMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 18:12:00 -0500
Date: Sun, 11 Jan 2004 23:11:53 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Aubin LaBrosse <arl8778@rit.edu>
Cc: Peter Lieverdink <peter@cc.com.au>, linux-kernel@vger.kernel.org,
       maverick@eskuel.net
Subject: Re: PCMCIA lockups on HP Pavilion laptop
Message-ID: <20040111231153.D10920@flint.arm.linux.org.uk>
Mail-Followup-To: Aubin LaBrosse <arl8778@rit.edu>,
	Peter Lieverdink <peter@cc.com.au>, linux-kernel@vger.kernel.org,
	maverick@eskuel.net
References: <1073191980.1505.32.camel@localhost.localdomain> <1073860473.1103.3.camel@kahlua> <1073862011.9478.11.camel@rain.rh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1073862011.9478.11.camel@rain.rh.rit.edu>; from arl8778@rit.edu on Sun, Jan 11, 2004 at 06:00:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 06:00:11PM -0500, Aubin LaBrosse wrote:
> On Sun, 2004-01-11 at 17:34, Peter Lieverdink wrote:
> > http://www.consultmatt.co.uk/nx9005/config.php
> > 
> > - Peter.
> 
> I'll keep that one in mind as well, thanks Peter.  Mathieu's reply
> (earlier in this thread) fixed it for me, i used the config he put in
> his mail.  thanks to all of you for your help and insight!
> 
> Russell, would it be useful to you if I tracked it down more precisely
> anyway? the config mathieu posted worked for me so i didn't look too
> deep, but if you'd like me to try and narrow it down so that we know
> which io space causes problems on these machines i could do that. 

Personally, I don't care very much - it's useful to know the affected
port range vs the machine, so when other people have the same problem
we don't have to re-investigate.

I'd rather there was some way to automatically mark these pesky regions
in the resource manager so we didn't have to do this, but I guess that's
going to be too much.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
