Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265427AbSJaWnt>; Thu, 31 Oct 2002 17:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265430AbSJaWnt>; Thu, 31 Oct 2002 17:43:49 -0500
Received: from newmail.somanetworks.com ([216.126.67.42]:50130 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S265427AbSJaWno>; Thu, 31 Oct 2002 17:43:44 -0500
Date: Thu, 31 Oct 2002 17:50:06 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Greg KH <greg@kroah.com>
cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "Lee, Jung-Ik" <jung-ik.lee@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: bare pci configuration access functions ?
In-Reply-To: <20021031221136.GC10689@kroah.com>
Message-ID: <Pine.LNX.4.33.0210311748050.26260-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Greg KH wrote:
[snip]
> Anyway, this is a nice diversion from the real problem here, for 2.4,
> should I just backport the pci_ops changes which will allow pci
> hotplugging to work again on ia64, or do we want to do something else?

It would be nice from a hotplug driver maintenance point of view if the
2.4 and 2.5 interfaces were the same IMO.  How about submitting the change
in 2.4.21-pre?

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

