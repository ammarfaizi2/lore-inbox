Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWJ1Pph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWJ1Pph (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 11:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWJ1Ppg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 11:45:36 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:50633 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1750938AbWJ1Ppg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 11:45:36 -0400
Date: Sat, 28 Oct 2006 09:45:35 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, gregkh@suse.de, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>, linux-pci@atrey.karlin.mff.cuni.cz,
       Yinghai Lu <yinghai.lu@amd.com>
Subject: Re: linux-2.6.19-rc2 PCI problem
Message-ID: <20061028154534.GR5591@parisc-linux.org>
References: <b6a2187b0610230824m38ce6fb2j65cd26099e982449@mail.gmail.com> <20061025013022.GG27968@stusta.de> <b6a2187b0610251754x7dc2c51aoad2244b8cdcb1c09@mail.gmail.com> <20061026152455.GI27968@stusta.de> <b6a2187b0610270649t4cc71781y8e1695f02e1c608e@mail.gmail.com> <20061027203109.GZ27968@stusta.de> <b6a2187b0610271805w154ca251tb7db33ed0926623@mail.gmail.com> <20061028032024.GD27968@stusta.de> <b6a2187b0610280324s66b06067od4691fa9f79420a7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a2187b0610280324s66b06067od4691fa9f79420a7@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 06:24:58PM +0800, Jeff Chua wrote:
> Up to 2.6.18, I was using "PCI access mode (Any)" and had no problem,
> but from  2.6.19-rc1 onwards, setting to "ANY" doesn't seem to work
> anymore.
> 
> I've just tested all 2.6.19-rc[123] and all are working with the
> "BIOS" setting, but not "ANY".

BIOS isn't a great option to choose ... how does Direct work out for
you?

I suspect you're having problems with the MMConfig method; confirming
that would be a good step towards debugging the problem.
