Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752256AbWAEWzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbWAEWzk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbWAEWzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:55:39 -0500
Received: from motgate8.mot.com ([129.188.136.8]:31723 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S1751216AbWAEWzj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:55:39 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Subject: RE: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Date: Thu, 5 Jan 2006 17:55:33 -0500
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD85@de01exm64.ds.mot.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Thread-Index: AcYSScI269FurwA4THmvIn9HWVNHbAAAIF4g
From: "Preece Scott-PREECE" <scott.preece@motorola.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "Alan Stern" <stern@rowland.harvard.edu>, <akpm@osdl.org>,
       <linux-pm@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I shouldn't oversimplify the power management in a cell phone. When I said we turned whole devices on/off, I was referring only to what the system-level PM (which uses suspend/resume) does. There's a fair amount of subsystem-specific power management outside the Linux suspend/resume framework. Some of it might be handled in the framework, if the framework were more capable.

scott

-----Original Message-----
From: Pavel Machek [mailto:pavel@ucw.cz] 
Sent: Thursday, January 05, 2006 4:46 PM
To: Preece Scott-PREECE
Cc: Alan Stern; akpm@osdl.org; linux-pm@lists.osdl.org; linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface

On Èt 05-01-06 17:21:38, Preece Scott-PREECE wrote:
> We do have multiple system-level low-power modes. I believe today they 
> differ in turning whole devices on or off, but there are some of those 
> devices that could be put in reduced-function/lowered-speed modes if 
> we were ready to use a finer-grained distinction.

I think we were talking multiple off modes for _single device_. It is good to know that even cellphones can get away with whole devices on/off today.
								Pavel

--
Thanks, Sharp!
