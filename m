Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbTBEVl5>; Wed, 5 Feb 2003 16:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbTBEVl5>; Wed, 5 Feb 2003 16:41:57 -0500
Received: from fmr01.intel.com ([192.55.52.18]:61419 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S264788AbTBEVl4>;
	Wed, 5 Feb 2003 16:41:56 -0500
Subject: Re: [PATCH][2.5.59-bk]Sysfs interface for ZT5550 Redundant Host
	Controller
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Scott Murray <scottm@somanetworks.com>
Cc: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
       Stanley Wang <stanley.wang@linux.co.intel.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302051606530.29820-100000@rancor.yyz.somanetworks.com>
References: <Pine.LNX.4.44.0302051606530.29820-100000@rancor.yyz.somanetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Feb 2003 13:40:36 -0800
Message-Id: <1044481237.2134.26.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-05 at 13:14, Scott Murray wrote:
> On 5 Feb 2003, Rusty Lynch wrote:
> 
> > Here is a second version of the zt5550 reduncant host controller sysfs
> > interface patch.  I have first of all removed several of the more advanced
> > (and therefore more dangerous) chip features, and also moved the root
> > of these files to the 'zt5550_hc' directory that was already being created
> > in bus/pci/drivers/ so that the directory view now looks like:
> 
> I'll likely poke around a bit more, but I can probably live with something 
> along these lines.  My objection to exposing stuff like the HCC, ISOC, and 
> ARBC registers is that my gut feel is that it would be a pain to handle 
> them getting changed arbitrarily from userspace inside the driver,
> especially if someone does the work to make it RSS capable.
> 
> Scott
> 
> PS: Are you still interested in changes to handle the ZT5550C versus 
>     ZT5550D issues, or are things working to your satisfaction at the 
>     moment?
> 

Since Stanley is seeing his ZT5550C work correctly with your latest
patches, I am assuming that I probably have some early engineering
version of the ZT5550C, and it isn't worth worrying about.

    --rustyl  

> 
> -- 
> Scott Murray
> SOMA Networks, Inc.
> Toronto, Ontario
> e-mail: scottm@somanetworks.com
> 


