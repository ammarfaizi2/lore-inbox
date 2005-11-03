Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVKDAAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVKDAAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbVKDAAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:00:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:23491 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932241AbVKDAAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:00:14 -0500
Subject: Re: 2.6.14: advansys & zd1201 on PowerMac 8500/G3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Mock <kd6pag@qsl.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1EXo7K-0003hp-4O@penngrove.fdns.net>
References: <E1EXo7K-0003hp-4O@penngrove.fdns.net>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 10:59:37 +1100
Message-Id: <1131062377.4680.105.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 15:03 -0800, John Mock wrote:
> I've got mixed results with new kernel on PowerMac 8500/G3.  Given a
> couple of my earlier patches for previous releases, my Advansys SCSI 
> card is finally showing signs working under 2.6!
> 
> Alas, i can't really test it adequately (hence no patch posted) as my
> wireless USB dongle (ZD1201) doesn't come up reliably after rebooting
> and seems to hang up randomly under interactive use.  Unplugging and
> then re-plugging it brings it back up, but i can't leave it that way as
> the machine also acts as a server.  I've not looked at this carefully
> yet, and will post more when i have a better understanding of what
> might be going wrong with this device.

PowerMac 8500 is an old fragile beast. Especially with a G3 processor
hooked on it. The venerable Apple Bandit PCI bridge can have some
"issues" every now and then with trivial things like ... cache coherency
(ugh !). It tends to hit things like USB pretty badly. I can't guarantee
for sure that's the cause of your problem, but it's possible...

Ben.


