Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVBSOuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVBSOuw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 09:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVBSOuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 09:50:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55681 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261569AbVBSOus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 09:50:48 -0500
Date: Sat, 19 Feb 2005 14:50:47 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [RFC: 2.6 patch] drivers/pci/: possible cleanups
Message-ID: <20050219145047.GB455@parcelfarce.linux.theplanet.co.uk>
References: <20050218235419.GE4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218235419.GE4337@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 12:54:19AM +0100, Adrian Bunk wrote:
> - remove the following unused functions:
>   - pci.c: pci_find_ext_capability

The pcie bridge driver ought to be using this.  I haven't submitted that
cleanup patch yet.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
