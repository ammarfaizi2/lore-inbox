Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269296AbTGVUmt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 16:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269392AbTGVUms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 16:42:48 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:20649
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S269296AbTGVUmq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 16:42:46 -0400
Date: Tue, 22 Jul 2003 16:57:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Erik Andersen <andersen@codepoet.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
Message-ID: <20030722205751.GB27179@gtf.org>
References: <20030722184532.GA2321@codepoet.org> <20030722185443.GB6004@gtf.org> <20030722190705.GA2500@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722190705.GA2500@codepoet.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 01:07:05PM -0600, Erik Andersen wrote:
> libata host adaptor driver hacked together in short order.  After
> all, the Intel one is just 400 lines.  So unless you (or anyone
> else) have already started or would prefer to do the honors,
> I'll try to hack something together this evening,

Just another note, don't be afraid to turn "outb-heavy" functions into
hook, that get reimplemented in a Promise-specific manner.
ata_pci_init_one will also likely need a bit of work for Promise.

	Jeff



