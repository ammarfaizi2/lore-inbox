Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267751AbUIXFdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbUIXFdY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 01:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267769AbUIXFdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 01:33:24 -0400
Received: from [202.125.86.130] ([202.125.86.130]:48341 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S267751AbUIXFdV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 01:33:21 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: keyword for rivafb in XF86Confige file 
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Fri, 24 Sep 2004 11:02:01 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811107E4F@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: keyword for rivafb in XF86Confige file 
thread-index: AcSh7sax+xxzfTKyRuOlbKAgQi8EqwAAHs7gAAHrUDA=
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
 
I am not able to make my X server work on rivafb (framebuffer module) which is loaded as a module on system.
 
Steps followd by me :-
 
# modprobe rivafb.o
modprobe : Can't locate mnodule rivafb.o
 
So, loaded the rivafb module along with other modules using insmod by checking the dependency list in "modules.dep".
 
I get the rivafb specific debug messages when I switch consoles. But I don't get them when I try to open a GUI Application in my X windows.
 
I edited "XF86Config-4" file
Driver "nvidia" . 
Is it the right keyword to invoke the rivafb driver. I got this on same maillists. Where in the system can I find the database for these keyword stuff.
 
Later, when I say
# startx
It says:-
(EE) Failed to load module "nvidia" (module does not exist, 0)
(EE) No devices detected.
 
What is going wrong here? Is there any other way through which I can tell the X server to use Framebuffer.
 
Please help.
 
My system configuration
Os                linux 7.3(kernel - 2.4.18)
Boot loader       lilo
Default runlevel  3
Framebuffer       rivafb
X server version  4.2.0 
 
Regards,
Mukund jampala
 
