Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263425AbUDUQ0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263425AbUDUQ0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 12:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263450AbUDUQ0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 12:26:43 -0400
Received: from mail.cyclades.com ([64.186.161.6]:39127 "EHLO mail.cyclades.com")
	by vger.kernel.org with ESMTP id S263425AbUDUQ0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 12:26:39 -0400
Date: Wed, 21 Apr 2004 13:27:16 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jason Brian Friedrich <jf@domainbox.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Kernel 2.4.26] Booting from Adaptec PCI-X 133 29320 Rev C
Message-ID: <20040421162716.GE15950@logos.cnet>
References: <40865DFD.9000405@domainbox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40865DFD.9000405@domainbox.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 01:41:49PM +0200, Jason Brian Friedrich wrote:
> Hello everyone,
> 
> we can not boot from an "Adaptec PCI-X 133 29320 Rev C" device when 
> using 2.4.26. We get a kernel panic and that the kernel could not 
> mount root (VFS: Unable to mount root fs on 08:03). With 2.4.25 
> everything works properly (its the same config) but we need the 
> security patches included in 2.4.26.
> 
> I have not found any entries in the changelog about changes in the 
> scsi drivers.

Jason, can you please save the boot messages from both 2.4.25 and 2.4.26? 

Maybe you have a serial console around or at least you copy the relevant 
parts (the card detection success with 2.4.25 and the card detection failure 
with 2.4.26), plus the config files for both cases, and send us?

That would be helpful. There are no aic7xxx changes in 2.4.26. Are you using ACPI?
