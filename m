Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUI0Jc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUI0Jc6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 05:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUI0Jc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 05:32:58 -0400
Received: from [202.125.86.130] ([202.125.86.130]:26600 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S266467AbUI0Jcz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 05:32:55 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Video : Activate X to use rivafb
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Mon, 27 Sep 2004 15:05:21 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811107FC3@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Video : Activate X to use rivafb
Thread-Index: AcSkc8/3xpd53OclQAyNny/UO18bjAAABe5g
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

The question I am asking may the simplest of this field, but I found it no where. Pls help.

How to activate X with rivafb framebuffer not the generic fb driver (fbdev).

I am working with the following configuration:-
* Red Hat Linux 7.3 
* Kernel 2.4.18-3 
* Nvidia Riva TNT card 
* Rivafb driver 
* XFree86 4.2.0 
 
My edited the XF86Confoig file as follows( related sections only):-

Section "device"
	Identifier "linix fb"
	Driver "rivafb"	# Is rivafb the right keyword for rivafb.o module?
	BoardName "Unknown"
EndSection

Section "Screen"
	Identifier "Screen0"
	Device "linux fb"
	Monitor "COMPAQ S510"
	DefaultDepth 8
	Subsection "Display"
		Depth 8
	EndSubSection 
EndSection

Is rivafb the right keyword for rivafb.o module?
Is it the driver name(module name) that we should keep in the Driver part of Device section?

If I startx afterb modprobing the rivafb, it results in errors. # startx 

(EE) Fialed to load module "rivafb" ( module does not exist, 0)
(EE) No devices detected.

Please help me in this regard. I have spend good enough time on this and its I high time get it done.

Is it so easy a question? Just becos I didn't find any info about in the internet and no body replies for question.

Aim Behind all this : 
To debug the rivafb driver when it being called or used by X server( XF86 ).

Regards,
Mukund jampala

