Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbTBEWKp>; Wed, 5 Feb 2003 17:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbTBEWKp>; Wed, 5 Feb 2003 17:10:45 -0500
Received: from ldap.somanetworks.com ([216.126.67.42]:30652 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S265051AbTBEWKo>; Wed, 5 Feb 2003 17:10:44 -0500
Date: Wed, 5 Feb 2003 17:20:15 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Greg KH <greg@kroah.com>
cc: Rusty Lynch <rusty@linux.co.intel.com>, Patrick Mochel <mochel@osdl.org>,
       Stanley Wang <stanley.wang@linux.co.intel.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.59-bk]Sysfs interface for ZT5550 Redundant Host
 Controller
In-Reply-To: <20030205220956.GB21652@kroah.com>
Message-ID: <Pine.LNX.4.44.0302051718120.29820-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2003, Greg KH wrote:

> On Wed, Feb 05, 2003 at 04:14:10PM -0500, Scott Murray wrote:
> > On 5 Feb 2003, Rusty Lynch wrote:
> > 
> > > Here is a second version of the zt5550 reduncant host controller sysfs
> > > interface patch.  I have first of all removed several of the more advanced
> > > (and therefore more dangerous) chip features, and also moved the root
> > > of these files to the 'zt5550_hc' directory that was already being created
> > > in bus/pci/drivers/ so that the directory view now looks like:
> > 
> > I'll likely poke around a bit more, but I can probably live with something 
> > along these lines.
> 
> Does that mean you want me to add this patch to the kernel tree?

If you're happy with the sysfs changes, feel free to apply.  I've got some
other fixes in hand, but I can remerge the ZT5550 driver ones later.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

