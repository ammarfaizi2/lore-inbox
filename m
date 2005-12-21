Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVLULey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVLULey (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 06:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVLULey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 06:34:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52161 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932372AbVLULex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 06:34:53 -0500
Subject: Re: [Linux 2.4.32] SATA ICH5/PIIX and Combined mode
From: Arjan van de Ven <arjan@infradead.org>
To: rol@as2917.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512211110.jBLBALD24852@tag.witbe.net>
References: <200512211110.jBLBALD24852@tag.witbe.net>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 12:34:51 +0100
Message-Id: <1135164891.3456.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-21 at 12:10 +0100, Paul Rolland wrote:
> Hello,
> 
> I have a machine with two SATA HDD, and one PATA CDRom.
> Bios is configured for combined mode, and installing a RedHat ES3
> (Kernel 2.4.21-ELsmp) is fine, the two HDD are up, the installation
> is fine and the CDRom is working.
> 
> Then, upgrading to a vanilla 2.4.32, the ata_piix.c file contains
> a "combined mode not supported" and booting the machine hangs, as
> no VFS are up for root device.

you can't reliably run a non-NPTL kernel on RHES3. Really. Are you
really sure you want to ? 

