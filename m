Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbTDQTuP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 15:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbTDQTuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 15:50:15 -0400
Received: from fmr04.intel.com ([143.183.121.6]:51926 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262047AbTDQTuO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 15:50:14 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C26308F@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Kristofer T. Karas'" <ktk@enterprise.bidmc.harvard.edu>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'steve.cameron@hp.com'" <steve.cameron@hp.com>
Subject: RE: How to identify contents of /lib/modules/*
Date: Thu, 17 Apr 2003 13:02:01 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kristofer T. Karas [mailto:ktk@enterprise.bidmc.harvard.edu]
>
> I have a worse problem.  :-)   I often run several instances of the
> identically version-numbered kernel, all available from the LILO boot
> menu, each instance having a different .config or perhaps compiled with
> a different gcc.  If each instance wants to share
> /lib/modules/[sameversion]/... then I've got a problem.

I solve that appending to EXTRAVERSION ... 2.5.66.5.2-rtfutex is the
latest build of the 20+ 2.5.66 slightly different kernels I have 
installed in the same machine for testing. And they all have different
module directories.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
