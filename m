Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUCEDiW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 22:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUCEDiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 22:38:22 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:49547 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262175AbUCEDiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 22:38:21 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: evbug.ko
Date: Thu, 4 Mar 2004 22:38:13 -0500
User-Agent: KMail/1.6
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>
References: <m3n06x4o0q.fsf@lugabout.jhcloos.org>
In-Reply-To: <m3n06x4o0q.fsf@lugabout.jhcloos.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403042238.13924.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 March 2004 04:30 pm, James H. Cloos Jr. wrote:
> Any idea what might modprobe evbug.ko w/o operator intervention?
> 

It's new hotplug scripts. Put modules you do not want to be automatically
loaded even if they think they have hardware/facilities to bind to into
/etc/hotplug/blacklist

I, for example, have evbug, joydev, tsdev and eth1394 there.

Greg, any chance adding evbug to the default version of hotplug package?

-- 
Dmitry
