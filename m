Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269042AbUJTWNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269042AbUJTWNT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269993AbUJTWLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:11:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34209 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269042AbUJTWDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:03:47 -0400
Date: Wed, 20 Oct 2004 23:03:47 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Hanna Linder <hannal@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       davej@codemonkey.org.uk
Subject: Re: [KJ] [RFT 2.6] intel-agp.c: replace pci_find_device with pci_get_device
Message-ID: <20041020220347.GZ16153@parcelfarce.linux.theplanet.co.uk>
References: <17420000.1098298334@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17420000.1098298334@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 11:52:14AM -0700, Hanna Linder wrote:
> 
> As pci_find_device is going away soon I have converted this file to use
> pci_get_device instead. I have compile tested it. If anyone has this hardware
> and could test it that would be great.

Should be converted to the pci_driver API.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
