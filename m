Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVAHAzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVAHAzn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 19:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVAHAzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 19:55:43 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:40886 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261690AbVAHAzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 19:55:35 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ncunningham@linuxmail.org
Subject: Re: 2.6.10-mm2: swsusp regression
Date: Sat, 8 Jan 2005 01:56:05 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050106002240.00ac4611.akpm@osdl.org> <200501071345.39847.rjw@sisk.pl> <1105135940.2488.39.camel@desktop.cunninghams>
In-Reply-To: <1105135940.2488.39.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501080156.06145.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 7 of January 2005 23:12, Nigel Cunningham wrote:
> Hi.
> 
> On Fri, 2005-01-07 at 23:45, Rafael J. Wysocki wrote:
> > > ..so... could you go through sysdev_register()s, one by one,
> > > commenting them to see which one causes the regression? That driver
> > > then needs to be fixed.
> > > 
> > > Go after mtrr and time in first places.
> > 
> > OK, but it'll take some time.
> 
> There's an MTRR fix in the -overloaded ck patches. Perhaps it is what
> you're after. (Or perhaps it's already included :>)
> 
> http://kem.p.lodz.pl/~peter/cko/fixes/2.6.10-cko1-swsusp_fix.patch

Thanks for pointing it out.  I have adapted this patch to -mm2, but 
unfortunately it does not fix the issue.  Still searching. ;-)

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
