Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbUCCUwI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 15:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbUCCUwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 15:52:08 -0500
Received: from [80.72.36.106] ([80.72.36.106]:11196 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261196AbUCCUwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 15:52:05 -0500
Date: Wed, 3 Mar 2004 21:51:59 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Tim Hockin <thockin@hockin.org>
Cc: linux-hotplug-devel@vger.kernel.org, greg@kroach.com,
       linux-kernel@vger.kernel.org
Subject: Re: [QUESTION/PROPOSAL] udev (fwd)
In-Reply-To: <20040303194034.GA4681@hockin.org>
Message-ID: <Pine.LNX.4.58.0403032150250.1319@alpha.polcom.net>
References: <Pine.LNX.4.58.0403032023090.1319@alpha.polcom.net>
 <20040303194034.GA4681@hockin.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2004, Tim Hockin wrote:

> On Wed, Mar 03, 2004 at 08:27:17PM +0100, Grzegorz Kulewski wrote:
> > So, (sorry if it was asked 100000000 times...
> 
> it has been
> 
> > ... but) why when kernel detects new device or module is loaded, no device 
> > file in sysfs is created? The device files in /dev would be only links to 
> > these in /sys. 
> 
> What mode should be applied to these files?  That alone is enough to make
> one stop and reconsider the idea.

For example 000 - no access for nobody, udev can change it if configured 
to do so.


Grzegorz

