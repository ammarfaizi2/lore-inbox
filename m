Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbUKKH6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbUKKH6b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 02:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbUKKH6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 02:58:31 -0500
Received: from ns.suse.de ([195.135.220.2]:46210 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262187AbUKKH6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 02:58:30 -0500
Date: Thu, 11 Nov 2004 08:57:49 +0100
From: Andi Kleen <ak@suse.de>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       ak@suse.de, akpm@osdl.org, greg@kroah.com,
       sundarapandian.durairaj@intel.com, tom.l.nguyen@intel.com
Subject: Re: [PATCH] pci-mmconfig fix for 2.6.9
Message-ID: <20041111075749.GA20822@wotan.suse.de>
References: <200411102220.iAAMKNx7030359@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411102220.iAAMKNx7030359@snoqualmie.dp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since the configuration write access for PCI Express is non posted,
> flushing is not necessary and  it will be safe to remove the dummy
> readl. 

Where is it guaranteed that these writes are non posted?

		-Andi
