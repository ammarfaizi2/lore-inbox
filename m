Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVIEFBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVIEFBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 01:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVIEFBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 01:01:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:29458 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932196AbVIEFBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 01:01:15 -0400
Date: Mon, 5 Sep 2005 07:01:08 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Sean <seanlkml@sympatico.ca>
Cc: Willy Tarreau <willy@w.ods.org>, Alex Davis <alex14641@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050905050108.GA16596@alpha.home.local>
References: <35547.10.10.10.10.1125892279.squirrel@linux1> <20050905040311.29623.qmail@web50204.mail.yahoo.com> <50570.10.10.10.10.1125893576.squirrel@linux1> <20050905043613.GD30279@alpha.home.local> <46230.10.10.10.10.1125895623.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46230.10.10.10.10.1125895623.squirrel@linux1>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 12:47:03AM -0400, Sean wrote:
> On Mon, September 5, 2005 12:36 am, Willy Tarreau said:
> 
> > Well, to be fair, most laptop users today are in companies which provide
> > them with the model the staff has chosen for all the employees. And
> > employees
> > try to install Linux on them anyway. That's how you end up with things
> > like
> > ndiswrapper, because the people who make those notebooks for companies
> > don't
> > care at all about their customers ; what they want is negociate with the
> > staff to sell them 2000 laptops, and that's all.
> 
> Companies that provide laptops to their employees tend to frown on the
> users installing a bunch of stuff anyway.

But how do you think Linux has penetrated the enterprise market ???
We all have put dual boots on every windows machine we had access to,
eventhough this was clearly forbidden. And after repeatedly showing
to the staff that you saved their day with your Linux, they finally
start to get interested to it. One of my best customers has finally
bought about one hundred RHEL3 licences to replace amateur installs
on production machines. They would never have looked at it without
us braving unauthorized dual boots.

> If the company was buying the
> laptop to run Linux it would be spec'd appropriately.
> 
> But the real crux of the argument here is not whether or not people should
> ever use binary-only drivers, it's whether the open source kernel
> developers should spend any time worrying about it or not.

I think we should not worry about it, but we should not deliberately break
it in a stable series when that does not bring anything. The fact that
Adrian proposed to completely remove the option is sad. It's in the windows
world that you can't choose. In Linux, you make menuconfig and choose what
suits your needs.

Regards,
Willy

