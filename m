Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWHLAWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWHLAWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 20:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWHLAWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 20:22:25 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:61899 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S932451AbWHLAWY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 20:22:24 -0400
Date: Sat, 12 Aug 2006 01:22:11 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Dave Jones <davej@redhat.com>, Thomas Koeller <thomas@koeller.dyndns.org>,
       wim@iguana.be, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20060812002211.GA8279@linux-mips.org>
References: <200608102319.13679.thomas@koeller.dyndns.org> <20060811205639.GK26930@redhat.com> <200608120149.23380.thomas@koeller.dyndns.org> <20060812000636.GB28540@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060812000636.GB28540@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 08:06:36PM -0400, Dave Jones wrote:

>  > I think they are. Remember, the entire device is integrated in the
>  > processor. No external buses involved.
> 
> Ok.

I think it's ok in this case, we're unlikely to see these peripherals
on other chips than PMC-Sierra's - but that's of course just a guess.

With a broader perspective the embedded world is increasingly converging
to using standardized components (so called "IP") and on-chip
interconnects such as OCP for new designs and portable drivers should
reflect this.

  Ralf
