Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270987AbTGVSjn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270988AbTGVSjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:39:43 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:34979
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S270987AbTGVSjl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:39:41 -0400
Date: Tue, 22 Jul 2003 14:54:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Erik Andersen <andersen@codepoet.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
Message-ID: <20030722185443.GB6004@gtf.org>
References: <20030722184532.GA2321@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722184532.GA2321@codepoet.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 12:45:33PM -0600, Erik Andersen wrote:
> Some folk I've done some consulting work for bought a zillion
> Promise SATA cards.  They were able to convince Promise to
> release their SATA driver, which was formerly available only as 
> a binary only kernel module, under the terms of the GPL.

That's definitely nice of the vendor.

FWIW it does not include any RAID format support.

> cards.  As a temporary download location, the GPL'd driver can be
> obtained from http://www.busybox.net/pdc-ultra-1.00.0.10.tgz

Bart, Alan, and I have been looking at this.  It uses the ancient CAM
model, that we don't really want to merge directly in the kernel.  It's
very close to the libata model, from the user perspective, so life is 
good.

	Jeff


