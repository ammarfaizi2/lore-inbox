Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752170AbWCCCcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbWCCCcf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 21:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbWCCCcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 21:32:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29068 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752157AbWCCCcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 21:32:11 -0500
Date: Thu, 2 Mar 2006 18:30:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net
Subject: Re: [PATCH 7/15] EDAC: i82875p cleanup
Message-Id: <20060302183049.7572f620.akpm@osdl.org>
In-Reply-To: <200603021748.01132.dsp@llnl.gov>
References: <200603021748.01132.dsp@llnl.gov>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson <dsp@llnl.gov> wrote:
>
> +	if (mci_pdev != NULL)
>  +		pci_dev_put(mci_pdev);

pci_dev_put(NULL) is legal.
