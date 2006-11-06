Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753265AbWKFPuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbWKFPuo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 10:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753267AbWKFPun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 10:50:43 -0500
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:56040 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S1753265AbWKFPum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 10:50:42 -0500
Message-ID: <454F59AB.9090403@lwfinger.net>
Date: Mon, 06 Nov 2006 09:50:03 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linville@tuxdriver.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] bcm43xx_sprom_write(): add error checks
References: <20061106142146.GN5778@stusta.de>
In-Reply-To: <20061106142146.GN5778@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The Coverity checker noted that these "if (err)"'s couldn't ever be 
> true.
> 
> It seems the intention was to check the return values of the 
> bcm43xx_pci_write_config32()'s?

Exactly. This patch sent to wireless-2.6.

Thanks,

Larry
