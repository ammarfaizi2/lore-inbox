Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbTDFHWZ (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 03:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbTDFHWZ (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 03:22:25 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:8465 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262854AbTDFHWZ (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 03:22:25 -0400
Date: Sat, 5 Apr 2003 23:33:49 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Stephan van Hienen <kernel@ddx.a2000.nu>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: onboard ICH4 seen as ICH3 (ultra100 controller onboard)
 (2.4.20/2.4.21-pre7)
In-Reply-To: <Pine.LNX.4.53.0304060006190.18036@ddx.a2000.nu>
Message-ID: <Pine.LNX.4.10.10304052330410.32611-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looking back over the thread, you have a failed cable detect.
I do not know why, but pat ide0=ata66 and ide1=ata66 to see if that is a
temp work-around.

You said nothing selected?

Does that mean your bios is set to [none] for all devices?
If so change it to [auto], [none] tends to do strange things.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

