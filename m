Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbTFFVyA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 17:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbTFFVx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 17:53:59 -0400
Received: from exchange-1.umflint.edu ([141.216.3.48]:7663 "EHLO
	Exchange-1.umflint.edu") by vger.kernel.org with ESMTP
	id S262299AbTFFVx6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 17:53:58 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.4.20 Modprobe setting of eth0,eth1 does not seem to work
Date: Fri, 6 Jun 2003 18:04:41 -0400
Message-ID: <37885B2630DF0C4CA95EFB47B30985FB020EC0D2@exchange-1.umflint.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.20 Modprobe setting of eth0,eth1 does not seem to work
Thread-Index: AcMsdAxvwglcuuz2RJiUTT2zBirapwAALh5Q
From: "Lauro, John" <jlauro@umflint.edu>
To: <jmerkey@s1.uscreditbank.com>, <linux-kernel@vger.kernel.org>
Cc: <jmerkey@utah-nac.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I assume you mean between keyboard and chair???

Anyways...

If I do anything semi-advanced with e1000 cards, I end up getting
Intel's drivers.  It's a minor pain when switching kernel versions
(especially to a different version number) as the default scripts
assume you are already booted (uname -r) in the kernel you are
building for and are not part of the kernel source tree...

I suggest you try e1000-5.0.43 from Intel, and also iANS-2.3.35 (or
higher if either of them have updates).

I don't know if you are doing any advanced features like vlan tagging
or not.  Anyways, it's one area that drivers from Intel's site does
work better then the native stock kernel drivers.  Specifically as an
example, virtual Ethernets over different vlan tags when combined with
vmware gsx server works with Intel's iANS, but not with the stock vlan
support.

I know, it doesn't answer your question...  but it gives you something
else to try...

> -----Original Message-----
> From: jmerkey@s1.uscreditbank.com
[mailto:jmerkey@s1.uscreditbank.com]
> Sent: Friday, June 06, 2003 5:40 PM
> To: linux-kernel@vger.kernel.org
> Cc: jmerkey@utah-nac.org
> Subject: 2.4.20 Modprobe setting of eth0,eth1 does not seem to work
> 
> 
> 
> In 2.4.20 if I attempt to use the Intel multiport e1000 drivers with
> modules.conf trying to hard set the eth0,eth1, etc. assignments
modprobe
> does
> not appear to be assigning the adapter aliases correctly.  I am
assuming
> this may be due to an interface issue between the Keyboard and
monitor. :-
> )
> 
> Modules.conf file attached.  Anyone got any ideas here?
> 
> Jeff
> 

