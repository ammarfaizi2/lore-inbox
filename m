Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbUCED60 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 22:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbUCED6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 22:58:25 -0500
Received: from mail016.syd.optusnet.com.au ([211.29.132.167]:34533 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262180AbUCED6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 22:58:24 -0500
From: Stuart Young <sgy-lkml@amc.com.au>
To: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: evbug.ko
Date: Fri, 5 Mar 2004 14:58:19 +1100
User-Agent: KMail/1.5.4
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>
References: <m3n06x4o0q.fsf@lugabout.jhcloos.org> <200403042238.13924.dtor_core@ameritech.net>
In-Reply-To: <200403042238.13924.dtor_core@ameritech.net>
Organization: AMC Enterprises P/L
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403051458.19633.sgy-lkml@amc.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2004 02:38 pm, Dmitry Torokhov wrote:
> On Wednesday 03 March 2004 04:30 pm, James H. Cloos Jr. wrote:
> > Any idea what might modprobe evbug.ko w/o operator intervention?
>
> It's new hotplug scripts. Put modules you do not want to be automatically
> loaded even if they think they have hardware/facilities to bind to into
> /etc/hotplug/blacklist
>
> I, for example, have evbug, joydev, tsdev and eth1394 there.
>
> Greg, any chance adding evbug to the default version of hotplug package?

Of note: evbug is in /etc/hotplug/blacklist in the Debian hotplug package by 
default, with a comment in said file about it being debian specific.


