Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbUBZNRn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 08:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262793AbUBZNRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 08:17:43 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:25095 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262785AbUBZNPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 08:15:44 -0500
Date: Thu, 26 Feb 2004 14:07:24 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Stian Jordet <liste@jordet.nu>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [RFC] ACPI power-off on P4 HT
Message-ID: <20040226130724.GA3704@alpha.home.local>
References: <1076145024.8687.32.camel@dhcppc4> <20040208082059.GD29363@alpha.home.local> <20040208090854.GE29363@alpha.home.local> <20040214081726.GH29363@alpha.home.local> <1076824106.25344.78.camel@dhcppc4> <20040225070019.GA30971@alpha.home.local> <1077695701.5911.130.camel@dhcppc4> <20040226075609.GA745@uberboxen> <20040226105744.GA3406@alpha.home.local> <1077798440.955.1.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077798440.955.1.camel@chevrolet.hybel>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 01:28:49PM +0100, Stian Jordet wrote:
> tor, 26.02.2004 kl. 11.57 skrev Willy Tarreau:
> > OK, could you try this patch ? please note that it's just a test patch, not
> > one which should be applied to any tree !
> > If it hangs, it may be interesting to know what is the last line displayed.
> > Please halt your system out of X11 to see console messages.
> > It works for me on the P4 HT 100% of the time now.
> 
> Hi Willy,
> 
> Do you have a similar patch for 2.6?

No, but since Marcelo recently told me that acpi_power_off() was the same in
2.4 and 2.6, I think it should apply without much difficulties. A dirty gpm
cut-n-paste in vi should be enough ;-)

Regards,
Willy

