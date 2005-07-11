Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVGKAYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVGKAYD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 20:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVGKAW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 20:22:26 -0400
Received: from compunauta.com ([69.36.170.169]:15823 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S262073AbVGKAVi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 20:21:38 -0400
From: Gustavo Guillermo =?iso-8859-1?q?P=E9rez?= 
	<gustavo@compunauta.com>
Organization: www.compunauta.com
To: linux-kernel@vger.kernel.org
Subject: [OT] SCSI Printer on AIC78XX without SCSI Terminator
Date: Sun, 10 Jul 2005 19:21:35 -0500
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507101921.36332.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I was tried to use a SCSI Printer, onto a AIC78XX (old and new driver), 
when driver load, it recognise the Scanner, the Printer and Panel, but may be 
the copier doesn't have an internal terminator, and driver hangs forever 
discovering unexistent 4th device. I do not wish to dissasemble the copier to 
solder the terminator, and I never deal with SCSI HW. Kernel I was tried: 
2.6.7, 2.4.23. but I think the driver does not change from 2.6.7 to 2.6.12.

I see the doc about this driver but I can't figure out wich of a lot options 
can help to not try to discover more than 3 devices... I'll have a chance to 
play with this machine the next week, then I'm taking ideas.

aic7xxx=seltime:2
this option wait for answer but the device 4º waits forever...
aic7xxx=no_reset
I don't....
aic7xxx=override_term
mmmmmm
....

The new driver support cmdline args?

If someone can share comment I would appreciate it

cheers
-- 
Gustavo Guillermo Pérez
Compunauta uLinux
www.compunauta.com
