Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWJMIvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWJMIvO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 04:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWJMIvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 04:51:14 -0400
Received: from mx10.go2.pl ([193.17.41.74]:23496 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1750962AbWJMIvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 04:51:13 -0400
Date: Fri, 13 Oct 2006 10:56:05 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: dj@david-web.co.uk
Subject: Re: Hardware bug or kernel bug?
Message-ID: <20061013085605.GA1690@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Linux Kernel <linux-kernel@vger.kernel.org>, dj@david-web.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610121753.23220.dj@david-web.co.uk>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-10-2006 18:53, David Johnson wrote:
> Hi,
> 
> I'm having a major problem on a system that I've been unable to track down. 
> When using scp to transfer a large file (a few gig) over the network 
> (@100Mbit/s) the system will reboot after about 5-10 minutes of transfer. No 
> errors, just a reboot. I have another identical system which exhibits the 
> same behaviour.
...
> I've tested with Centos' 2.6.9 kernel and with a vanilla 2.6.17.13 kernel and 
> the results are the same with both.
...
> Any suggestions for more ways to debug this would be greatfully received.

I'd try with this:
- minimal workable config with a lot of debugging turned on (e.g. no:
smp, floppy, parport, mouse, ipv6, video, clock modulation, apm, acpi
buttons, thermal etc. - only base acpi or no if possible),
- 2.4 kernel,
- other distro e.g. live-cd knoppix,
- other transfer method like ftp (all superfluous services turned off).

Jarek P. 
