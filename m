Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVEWFft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVEWFft (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 01:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVEWFfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 01:35:48 -0400
Received: from [202.125.86.130] ([202.125.86.130]:36227 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261845AbVEWFfo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 01:35:44 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Tune the Touch driver co-ordinates .. help
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Mon, 23 May 2005 11:13:42 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348114BF2F4@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Tune the Touch driver co-ordinates .. help
thread-index: AcVfV82DaFXDmvPTTfGcdY0GyoAkPg==
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi All,
 
I have a touch driver whose architecture is as follows:-
 
My touch driver is a misc registered driver which has 2 ISRs. One is the touch screen ISR whereas the other is the timer ISR. When a touch made on the screen, the touch ISR is invoked which then initiates the timer interrupt. The timer interrupt will continuously call the timer ISR, which will read the X, Y, Z1, Z2 values from the H/W registers. The driver finds the valid X, Y co-ordinates and supplies to the application when read from the device.
 
In a touch driver with this architecture, I am facing a touch calibration problem.
 
Now, if I want to tune the calibration how do I resolve this?
 
Thanks in advance.
 
Regards,
Mukund Jampala

