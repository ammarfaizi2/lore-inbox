Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbVBKQTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVBKQTb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 11:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVBKQTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 11:19:31 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:43146 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262268AbVBKQT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 11:19:26 -0500
From: Christian =?iso-8859-15?q?Borntr=E4ger?= 
	<christian@borntraeger.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Date: Fri, 11 Feb 2005 17:19:22 +0100
User-Agent: KMail/1.7.1
Cc: Bill Nottingham <notting@redhat.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050211004033.GA26624@suse.de> <20050211031823.GE29375@nostromo.devel.redhat.com> <1108104417.32129.7.camel@localhost.localdomain>
In-Reply-To: <1108104417.32129.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502111719.23163.christian@borntraeger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 February 2005 07:46, Greg KH wrote:
> And finally, even if you do use udevstart to manager /sbin/hotplug
> events, you still need a module autoloader program.  This package
> provides executables for that problem, if you don't want to (or you
> can't) use the existing linux-hotplug scripts.  udev will never do the
> module loading logic, so there's no duplication in this case.

Greg,
the pci module autoloader is a real agent, which means it depends on having a 
hotplug event. Are you planning to support a scan for already present 
devices, like the pci.rc file in current hotplug solutions?

cheers

Christian
