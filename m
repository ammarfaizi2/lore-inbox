Return-Path: <linux-kernel-owner+w=401wt.eu-S1751481AbXAOUjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbXAOUjE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 15:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbXAOUjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 15:39:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:4540 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbXAOUjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 15:39:03 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:from;
        b=EgQ9p462SiNHxwvi74Hc/+Ad+5qMpqyAZ0CqIy8vlDAweQeX+iibZC4hX/KBe5T2yL8erkdYgw2eRu/P31GhGCO9VufBcMeU+e2zp4XqCiEV6R9kF9bhFr2Hbr9PmLj/MUC4MYpc3sOG2c+eBYx3GnoT+6O0km/MwPLYzCWQyD8=
Date: Mon, 15 Jan 2007 22:38:37 +0200
To: Greg KH <greg@kroah.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc5] intel_rng: substitue magic PCI IDs with macros
Message-ID: <20070115203837.GB29070@Ahmed>
Mail-Followup-To: Greg KH <greg@kroah.com>, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2007 at 04:29:48PM -0800, Greg KH wrote:
> On Sun, Jan 14, 2007 at 07:24:21PM +0200, Ahmed S. Darwish wrote:
> > Substitue intel_rng magic PCI IDs values used in the IDs table
> > with the macros defined in pci_ids.h
>
> Why not use the PCI_DEVICE() macro too?  It should make the lines even
> smaller.

Just for the patch applier, It seems that my mailer got insane. 
I've updated the patch to include PCI_DEVICE as Mr. Greg KH said But it 
appears in the LKML above his mail. 

So if no more suggestions come, the final patch is in:
http://lkml.org/lkml/2007/1/15/110

Thanks,
-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
