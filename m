Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTLOR50 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTLOR50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:57:26 -0500
Received: from smtp.terra.es ([213.4.129.129]:9051 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S263805AbTLOR5Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:57:25 -0500
Date: Mon, 15 Dec 2003 18:57:22 +0100
From: "grundig@teleline.es" <grundig@teleline.es>
To: Toad <toad@amphibian.dyndns.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: 'bad: scheduling while atomic!', preempt kernel, 2.6.1-test11,
 reading an apparently duff DVD-R
Message-Id: <20031215185722.43d87505.grundig@teleline.es>
In-Reply-To: <20031215174908.GA29901@amphibian.dyndns.org>
References: <20031215135802.GA4332@amphibian.dyndns.org>
	<Pine.LNX.4.58.0312150715410.1488@home.osdl.org>
	<3FDDD923.30509@pobox.com>
	<20031215174908.GA29901@amphibian.dyndns.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 15 Dec 2003 17:49:08 +0000 Toad <toad@amphibian.dyndns.org> escribió:

> I've been completely unable to get cdrtools to compile... The version in
> debian is 2.0a19, which works with IDE-SCSI, and doesn't work without

I've been burning cds with cdrecord in debian (sid) for months without
ide-scsi.


> > P.S. Yes, libata will probably (not definite) use the SCSI layer to 
> > drive ATAPI devices... but that's a long way off, and will not be using 
> > the ide-scsi code.  ide-scsi is basically a glue driver specifically for 
> > drivers/ide.

IIRC, some devices (ie: some tape devices) need ide-scsi too. They should be
ported instead of fixing ide-scsi?
