Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTLBFUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 00:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTLBFUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 00:20:21 -0500
Received: from codepoet.org ([166.70.99.138]:35818 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S263364AbTLBFUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 00:20:20 -0500
Date: Mon, 1 Dec 2003 22:20:15 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Joe Blow <joeblow341@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Promise 20378 + 2.6.0-test10 + libata patch 1
Message-ID: <20031202052015.GA28551@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jeff Garzik <jgarzik@pobox.com>, Joe Blow <joeblow341@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <BAY7-F848IdgO3RQppH0000114d@hotmail.com> <3FCC014A.7050109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCC014A.7050109@pobox.com>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Dec 01, 2003 at 10:04:42PM -0500, Jeff Garzik wrote:
> Joe Blow wrote:
> >
> >>From: Jeff Garzik <jgarzik@pobox.com>
> >>
> >>Nope, libata Promise driver only supports Serial ATA.
> >
> >
> >Bummer.  Will it ever support PATA?
> 
> No plans.

What exactly is needed to get got SATA and PATA support
comparable to the driver provided by promise?  Would it be
possible to adapt the existing promise PATA IDE driver to drive
the PATA port, while the libata Promise driver handles the SATA
ports.  Or would a new driver be needed?

How would the two drivers share the same PCI device?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
