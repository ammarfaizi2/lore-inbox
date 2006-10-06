Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422696AbWJFTQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422696AbWJFTQv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422685AbWJFTQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:16:51 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:12200 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422680AbWJFTQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 15:16:50 -0400
Message-ID: <4526AB94.7060200@garzik.org>
Date: Fri, 06 Oct 2006 15:16:36 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Val Henson <val_henson@linux.intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
References: <1160161519800-git-send-email-matthew@wil.cx>
In-Reply-To: <1160161519800-git-send-email-matthew@wil.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> Since some devices may not implement the MWI bit, we should check that
> the write did set it and return an error if it didn't.
> 
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>

ACK, though (as it seems you are doing) you should audit pci_set_mwi() 
users to make sure behavior matches up with this implementation

	Jeff



