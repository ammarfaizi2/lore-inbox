Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264156AbTHZOXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTHZOVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:21:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40719 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264131AbTHZOU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:20:28 -0400
Date: Tue, 26 Aug 2003 15:20:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Tom Marshall <tommy@home.tig-grr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with PCMCIA (Texas Instruments PCI1410)
Message-ID: <20030826152022.A28810@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Marshall <tommy@home.tig-grr.com>,
	linux-kernel@vger.kernel.org
References: <20030813205037.GA11977@home.tig-grr.com> <20030813221254.H20676@flint.arm.linux.org.uk> <20030813212610.GA12315@home.tig-grr.com> <20030826140541.GA691@home.tig-grr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030826140541.GA691@home.tig-grr.com>; from tommy@home.tig-grr.com on Tue, Aug 26, 2003 at 07:05:41AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 07:05:41AM -0700, Tom Marshall wrote:
> On Wed, Aug 13, 2003 at 02:26:10PM -0700, Tom Marshall wrote:
> > > Could you show the kernel messages from boot as well as the above
> > > messages please?
> > 
> > Here it is.  Below that is a more complete lspci output.
> > 
> > [...]
> 
> Is there any more information on this problem?  Is it a problem with the
> PCI1410 chip or the way it's integrated?  I would really like to get this
> working.  I can run test builds, or perhaps even try to find the problem
> myself if someone can verify that the chip should work with yenta_socket.

I'm waiting for more people to send me problem reports.  Currently, it
looks like PCI1410 and OZ6912 cardbus controllers, and one VG469 ISA
PCMCIA controller are affected.

If there's anyone who has found this problem and hasn't reported it, it
would be most useful if they could put together a report (containing the
requested information.) so we get more datapoints.

Someone else mentioned that the problem occurred (iirc) sometime between
2.5.70 and 2.5.75, which is when the bulk of the major pcmcia changes
went in... so it isn't that useful.

Also note that I'm unable to reproduce the problem on either my ARM
system containing a CL6833 Cardbus controller nor my IBM Thinkpad
with a TI PCI1250, so I'm completely dependent on getting reports from
the community to solve this issue.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

