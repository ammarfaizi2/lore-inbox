Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVBSNlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVBSNlK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 08:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVBSNlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 08:41:10 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:9122 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261714AbVBSNlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 08:41:07 -0500
Date: Sat, 19 Feb 2005 14:41:06 +0100
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: linux-kernel@vger.kernel.org
Subject: Re: FAUmachine: Looking for a good documented DMA bus master capable PCI IDE Controller card
Message-ID: <20050219134106.GI16858@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	linux-kernel@vger.kernel.org
References: <20050219102410.GD16858@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050219102410.GD16858@cip.informatik.uni-erlangen.de>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
to clear things up. We implemented the PIIX IDE controller as part of
the Intel Southbridge 82371AB which is part of the South bridge and a
*onboard* chip. This chip has only two IDE channels AFAIK.

The best thing would be if there is a PCI card or another chipset which
has a PIIX IDE controller with more channels.

Otherwise I look for another easy to implement IDE Bus Master capable
chip with 2 channels which I can implement as PCI Card to use more of
the card to get more DMA capable IDE channels in the virtual machine.

	Thomas
