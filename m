Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTDKWbU (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbTDKWbU (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:31:20 -0400
Received: from fmr06.intel.com ([134.134.136.7]:28151 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261892AbTDKWbS convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 18:31:18 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBAAB9@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Steven Dake'" <sdake@mvista.com>, "'Greg KH'" <greg@kroah.com>
Cc: "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'linux-hotplug-devel@lists.sourceforge.net'" 
	<linux-hotplug-devel@lists.sourceforge.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'message-bus-list@redhat.com'" <message-bus-list@redhat.com>
Subject: RE: [ANNOUNCE] udev 0.1 release
Date: Fri, 11 Apr 2003 15:42:46 -0700
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
> There is no "spec" that states this is a requirement, however, telecom
> customers require the elapsed time from the time they request the disk
> to be used, to the disk being usable by the operating system to be 20
msec.

How do you qualify "request"?

Is it plug the cable? Insert the disk into the bay? 
Flip a switch on? Manually? Computer controlled?

I cannot think of a physical action to plug a disk to a system that
is going to take an amount of time small enough so that 20 msec is
not noise.

A computer controlled switch might make sense, assuming the disk is
already powered, spinning and ready to rock - still, I guess SCSI
would like to enumerate it ... dunno how that works.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
