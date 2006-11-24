Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757807AbWKXRNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757807AbWKXRNR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 12:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757808AbWKXRNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 12:13:17 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:23264 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1757806AbWKXRNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 12:13:16 -0500
Message-ID: <4567282B.5080700@s5r6.in-berlin.de>
Date: Fri, 24 Nov 2006 18:13:15 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: ohci1394 oops bisected [was Re: 2.6.19-rc5-mm2 (Oops in	class_device_remove_attrs
 during nodemgr_remove_host)]
References: <455DCEF7.3060906@s5r6.in-berlin.de> <455DD42B.1020004@s5r6.in-berlin.de> <20061118094706.GA17879@kroah.com> <455EEE17.4020605@s5r6.in-berlin.de> <455F3DED.3070603@s5r6.in-berlin.de> <455F7EDD.6060007@s5r6.in-berlin.de> <20061119162220.GA2536@inferi.kami.home> <456090C9.1040900@s5r6.in-berlin.de> <20061119123348.4c961515.akpm@osdl.org> <4560C612.7040406@s5r6.in-berlin.de> <20061124084114.GE14340@kroah.com>
In-Reply-To: <20061124084114.GE14340@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, Nov 19, 2006 at 10:01:06PM +0100, Stefan Richter wrote:
...
>> at the moment I actually don't want to spend any more time on this
...
>> There are older ieee1394 bugs in
>> mainline with bigger practical impact for me to work on. If there are
>> still issues once ieee1394 was converted away from class_device, I'm OK
>> with revisiting it.
> 
> I'll hold off on submitting the network change to mainline until I fix
> this problem, so it might be a while...

In case you find the ieee1394 stack doing weird things to the driver
core, point it out. I'm not good at analyzing and (re)designing such
things but I might be able to contribute once I'm given clear
directions. ;-)
-- 
Stefan Richter
-=====-=-==- =-== ==---
http://arcgraph.de/sr/
