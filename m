Return-Path: <linux-kernel-owner+w=401wt.eu-S1751181AbXAOSeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbXAOSeK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 13:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbXAOSeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 13:34:10 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50444 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751301AbXAOSeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 13:34:09 -0500
Date: Mon, 15 Jan 2007 18:45:40 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Olivier Galibert <galibert@pobox.com>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: What does this scsi error mean ?
Message-ID: <20070115184540.2b3c4f78@localhost.localdomain>
In-Reply-To: <20070115171602.GA23661@dspnet.fr.eu.org>
References: <20070115171602.GA23661@dspnet.fr.eu.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2007 18:16:02 +0100
Olivier Galibert <galibert@pobox.com> wrote:

> sd 0:0:0:0: SCSI error: return code = 0x08000002
> sda: Current: sense key: Hardware Error
>     ASC=0x42 ASCQ=0x0

I'll give you a clue: The words "Hardware Error".

Run a SCSI verify pass on the drive with some drive utilities and see
what happens. If you are lucky it'll just reallocate blocks and decide
the drive is ok, if not well see what the smart data thinks.

Alan


