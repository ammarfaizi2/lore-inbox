Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVAHTNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVAHTNS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 14:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVAHTNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 14:13:18 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:21749 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261271AbVAHTNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 14:13:16 -0500
To: Christoph Hellwig <hch@lst.de>
Cc: davej@redhat.com, hannal@us.ibm.com, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <20050108190815.GA7031@lst.de>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 08 Jan 2005 11:13:14 -0800
In-Reply-To: <20050108190815.GA7031@lst.de> (Christoph Hellwig's message of
 "Sat, 8 Jan 2005 20:08:15 +0100")
Message-ID: <52fz1b20qd.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH] fix pci_get_device conversion in intel-agp
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 08 Jan 2005 19:13:15.0251 (UTC) FILETIME=[1A9C2430:01C4F5B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > +	if (intel_i810_private.i810_dev)
    > +		pci_dev_put(intel_i810_private.i830_dev);
    > +	if (intel_i810_private.i830_dev)
    > +		pci_dev_put(intel_i830_private.i830_dev);

Is there a typo in the patch here -- should the first put be for i810_dev?

 - R.
