Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVF1OmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVF1OmN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVF1OmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:42:12 -0400
Received: from [85.8.12.41] ([85.8.12.41]:15289 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261759AbVF1OlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:41:10 -0400
Message-ID: <42C16162.2070208@drzeus.cx>
Date: Tue, 28 Jun 2005 16:40:34 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kylene Jo Hall <kjhall@us.ibm.com>
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>, LKML <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com, tpmdd-devel@lists.sourceforge.net
Subject: Re: 2.6.12 breaks 8139cp
References: <42B9D21F.7040908@drzeus.cx>	 <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx>	 <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx>	 <42C0EE1A.9050809@drzeus.cx>  <42C1434F.2010003@drzeus.cx> <1119967788.6382.7.camel@localhost.localdomain>
In-Reply-To: <1119967788.6382.7.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kylene Jo Hall wrote:

>I believe that the reason that unloading the module does not help is
>because the module_exit is calling pci_disable in the tpm_remove
>function.  I'll generate a patch to remove this.
>
>Additionally this version of the driver  was doing a bunch of stuff to
>the LPC bus that I have since found not to be necessary and removed in
>patches that have been applied to the mm tree and were pushed to
>mainline this week.  Can anyone verify if this is still happening with
>the -mm patch?
>
>  
>

You wouldn't happen to have just your patches available?

Rgds
Pierre

