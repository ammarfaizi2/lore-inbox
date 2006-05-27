Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751560AbWE0PpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWE0PpO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 11:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWE0PpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 11:45:14 -0400
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:56014 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751560AbWE0PpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 11:45:12 -0400
From: Kimmo Sundqvist <kimmo.sundqvist@mbnet.fi>
Organization: Unorganized
To: linux-kernel@vger.kernel.org
Subject: Thinkpad port replicator's PS/2 mouse port broken
Date: Sat, 27 May 2006 18:44:40 +0300
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605271844.40763.kimmo.sundqvist@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Booting Ubuntu with 2.6.12 kernel, the internal trackpoint and the external 
mouse connected to the port replicator's mouse port work fine. Booting Gentoo 
with 2.6.14 kernel, only the internal mouse (trackpoint) works. It produces 
output to /dev/psaux and /dev/input/mice, whereas the mouse connected to the 
port replicator's mouse port does not.

Booting Gentoo with 2.6.12, both mouses again work, and catting /dev/psaux 
and /dev/input/mice produce characters.

The machine is a Thinkpad T22. There must have happened something in kernel 
development between 2.6.12 and 2.6.14 that broke the port replicator's PS/2 
mouse port. Is there anything I could try to fix this?

There is only a keyboard PS/2 port at the back of the machine per se. I have 
no idea if mouse works in that port. The point is, the mouse is not working 
in the port replicator's mouse port with 2.6.14 and newer kernels. The 
replicator has both PS/2 keyboard and mouse ports.

I have no idea if the external mouse will work with 2.6.13 but unless someone 
comes up with the idea of the cause, I can try it if requested.

Please CC all answers to me

-Kimmo Sundqvist
