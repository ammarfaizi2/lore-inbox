Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbTBEVEl>; Wed, 5 Feb 2003 16:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbTBEVEk>; Wed, 5 Feb 2003 16:04:40 -0500
Received: from newmail.somanetworks.com ([216.126.67.42]:58014 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S264915AbTBEVEj>; Wed, 5 Feb 2003 16:04:39 -0500
Date: Wed, 5 Feb 2003 16:14:10 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
       Stanley Wang <stanley.wang@linux.co.intel.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.59-bk]Sysfs interface for ZT5550 Redundant Host
 Controller
In-Reply-To: <1044478128.2270.17.camel@vmhack>
Message-ID: <Pine.LNX.4.44.0302051606530.29820-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Feb 2003, Rusty Lynch wrote:

> Here is a second version of the zt5550 reduncant host controller sysfs
> interface patch.  I have first of all removed several of the more advanced
> (and therefore more dangerous) chip features, and also moved the root
> of these files to the 'zt5550_hc' directory that was already being created
> in bus/pci/drivers/ so that the directory view now looks like:

I'll likely poke around a bit more, but I can probably live with something 
along these lines.  My objection to exposing stuff like the HCC, ISOC, and 
ARBC registers is that my gut feel is that it would be a pain to handle 
them getting changed arbitrarily from userspace inside the driver,
especially if someone does the work to make it RSS capable.

Scott

PS: Are you still interested in changes to handle the ZT5550C versus 
    ZT5550D issues, or are things working to your satisfaction at the 
    moment?


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com


