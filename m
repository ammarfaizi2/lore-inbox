Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264046AbTJFSA7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbTJFSA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:00:59 -0400
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:27624 "EHLO
	office.lsg.internal") by vger.kernel.org with ESMTP id S264044AbTJFSAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:00:54 -0400
Message-ID: <3F81ADC8.3090403@backtobasicsmgmt.com>
Date: Mon, 06 Oct 2003 11:00:40 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Christian Borntraeger <CBORNTRA@de.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 0/6] Backing Store for sysfs
References: <OF6873DDE8.877C0EE8-ONC1256DB7.005F0935-C1256DB7.0060DEDC@de.ibm.com> <20031006174128.GA4460@kroah.com>
In-Reply-To: <20031006174128.GA4460@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> 
> That's good.  But what happens after you run a find over the sysfs tree?
> Which is essencially what udev will be doing :)
> 

This sounds like an opportunity to improve the udev<->sysfs 
interaction. Does the hotplug event not give udev enough information 
to avoid this "find" search?

