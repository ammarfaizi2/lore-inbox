Return-Path: <linux-kernel-owner+w=401wt.eu-S932693AbWLSIww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbWLSIww (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbWLSIwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:52:51 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:33948 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932685AbWLSIwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:52:50 -0500
Date: Tue, 19 Dec 2006 01:52:49 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] drivers/pci/quirks.c: cleanup
Message-ID: <20061219085249.GL21070@parisc-linux.org>
References: <20061219041315.GE6993@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219041315.GE6993@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 05:13:15AM +0100, Adrian Bunk wrote:
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci );
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci );

Why all the crazy spacing?

+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5597, quirk_nopcipci);
