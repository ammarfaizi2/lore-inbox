Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265368AbTLHKXk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 05:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265372AbTLHKXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 05:23:40 -0500
Received: from tag.witbe.net ([81.88.96.48]:5393 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S265371AbTLHKXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 05:23:37 -0500
Message-Id: <200312081023.hB8ANZD26556@tag.witbe.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Zwane Mwaikambo'" <zwane@arm.linux.org.uk>,
       "'Paul Rolland'" <rol@witbe.net>
Cc: <linux-smp@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: WARNING: MP table in the EBDA can be UNSAFE
Date: Mon, 8 Dec 2003 11:23:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <Pine.LNX.4.58.0312051113260.10913@montezuma.fsmlabs.com>
Thread-Index: AcO7S/0d3wbro2XIRqiPT65XZrym5wCKSB9w
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > > Did you compile your kernel with the following option?
> > > IBM x440 Summit/EXA support
> > >
> > > CONFIG_X86_SUMMIT
> > >
> > I can't find this option ? Is this part of the 2.4.x branch ?
> 
> Indeed it is, you need to turn on "Multi-node NUMA system support"
> 
> CONFIG_X86_NUMA

That was it !

Great, the machine now sees all its CPUs.

The BogoMips number is rather strange (200 for a Xeon 2.4 GHz), but
the machine is really fine now....

Regards,
Paul

