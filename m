Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTDLEK7 (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 00:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTDLEK7 (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 00:10:59 -0400
Received: from fmr05.intel.com ([134.134.136.6]:29120 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263129AbTDLEK6 convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 00:10:58 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBAB1C@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Steven Dake'" <sdake@mvista.com>, "'Greg KH'" <greg@kroah.com>
Cc: "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: RE: [ANNOUNCE] udev 0.1 release
Date: Fri, 11 Apr 2003 21:22:34 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Steven Dake [mailto:sdake@mvista.com]
>
> Without blocking until the device is created and ready to be used, it
> becomes difficult to actually "hotswap insert" and then immediatly use
> the device, requiring polling.  Most users would like to wait for the
> event to complete, or have a select()able fd to wait on to know when the
> event has been completed.
> 
> This might be possible to emulate through dnotify, but would still
> require a rescan of the dev directory, causing poor performance. 

Would you take a look at the patch I just sent and tell me if something
along the lines of that would help? [the subject is Simple Kernel-User
Event Interface]

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
