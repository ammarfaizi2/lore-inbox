Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTFGTSl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 15:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTFGTSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 15:18:41 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27542
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263461AbTFGTSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 15:18:40 -0400
Subject: Re: Using SATA in PATA compatible mode?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adriaan Peeters <apeeters@lashout.net>
Cc: Jurgen Kramer <gtm.kramer@inter.nl.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1054987313.495.19.camel@bari.lashout.net>
References: <1054932405.2156.5.camel@paragon.slim>
	 <1054947612.17190.32.camel@dhcp22.swansea.linux.org.uk>
	 <1054987313.495.19.camel@bari.lashout.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055014188.17185.50.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jun 2003 20:29:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-06-07 at 13:01, Adriaan Peeters wrote:
> > The source code for the SATA chips will not be released, due to
> competitive
> > reasons. We support the linux distributions of Suse and Redhat mainly.
> > 
> > A partial open source code will become available in due time, but we do not
> > expect that this year.
> 
> I hope they changed course :)

They've released GPL code for the base stuff but not their raid layout
things. It claims to be a scsi driver because the 20376 has command
queueing and other goodies that our PATA thinking IDE layer can't handle.

(Btw Bart whats the status on switching to taskfile for 2.5.x now ?)

