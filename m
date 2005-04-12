Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVDLQoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVDLQoL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVDLQnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:43:00 -0400
Received: from mtk-sms-mail01.digi.com ([66.77.174.18]:18740 "EHLO
	mtk-sms-mail01.digi.com") by vger.kernel.org with ESMTP
	id S262472AbVDLQme convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:42:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Digi Neo 8: linux-2.6.12_r2  jsm driver
Date: Tue, 12 Apr 2005 11:42:31 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F12215A@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Digi Neo 8: linux-2.6.12_r2  jsm driver
Thread-Index: AcU/e/7y/1cdDwyCRgOibNlVSysg5QAADJiQ
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Jan-Benedict Glaw" <jbglaw@lug-owl.de>
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "Ihalainen Nickolay" <ihanic@dev.ehouse.ru>, <admin@list.net.ru>,
       <linux-kernel@vger.kernel.org>, "Wen Xiong" <wendyx@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

> But please be prepared to be in a competitive position. You've won't
get
> your driver included by just telling once about it; you'll need to
work
> towards that goal, and probably monitor the driver to be useable in
the
> future.

The JSM driver is a "stripped" down version of the DGNC driver.

There is no "competition" between these 2 drivers.
They were always intended to work side by side with each other.

Both drivers will get all fixes/changes added to them at the same time,
since 90% of the driver code is the same.

The JSM driver was forced to be stripped down when being submitted
to the kernel sources, and many extended features removed as so to be
included into the kernel, as the extended features added special ioctls
and special /proc (/sys for 2.6) files.

Oddly enough, I have had a few of our customers come back to me, after
seeing some of the previous JSM threads about yanking the extended
features,
and I quote:

> I didn't think that you would remove them. I read the posts and
> wondered *why* they wanted the management pieces removed.
> One reason to use the Digi products is for the sole fact that
> they *can* be diagnosed.
> I'm glad that Digi is still focused properly.
> I agree that committing the drivers to the main kernel
> is not the way to go if you are forced to remove dpa and ditty.

But this is neither here nor there, as Christoph has made it clear,
actual "Digi customers" don't matter.

I will let the chips fall where they will, and clean up the mess that
will soon be introduced into my driver world. =)

Scott

