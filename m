Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266697AbUF3PhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266697AbUF3PhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266717AbUF3Pdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:33:44 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:10706 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266737AbUF3PcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:32:15 -0400
Date: Wed, 30 Jun 2004 16:31:34 +0100
From: Dave Jones <davej@redhat.com>
To: augustus@penguin.linuxhardware.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] K8T800Pro AGP Support
Message-ID: <20040630153134.GD12311@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	augustus@penguin.linuxhardware.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0406292326480.24803@penguin.linuxhardware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406292326480.24803@penguin.linuxhardware.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 11:38:54PM -0400, augustus@penguin.linuxhardware.org wrote:
 > Patch to add support for the K8T800Pro chip in the AGPGART driver for 
 > amd64-agp.
 > 
 > Signed-off-by: Kris Kersey <augustus@linuxhardware.org>

Applied, thanks.

 > +#define PCI_DEVICE_ID_VIA_K8T800PRO_0  0x0282
 >  #define PCI_DEVICE_ID_VIA_8363_0       0x0305 
 >  #define PCI_DEVICE_ID_VIA_8371_0       0x0391
 >  #define PCI_DEVICE_ID_VIA_8501_0       0x0501

Although normally, it's preferred to use the chip number instead
of its marketing name. A quick google didn't actually turn up
its number though, so for the time being, I'll leave it like this.

		Dave

