Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269127AbUI2WIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269127AbUI2WIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 18:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269103AbUI2WID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 18:08:03 -0400
Received: from cantor.suse.de ([195.135.220.2]:30906 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269102AbUI2WHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 18:07:10 -0400
Date: Thu, 30 Sep 2004 00:07:09 +0200
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2: Kernel BUG at slab:2139 on dual AMD64
Message-ID: <20040929220709.GD26714@wotan.suse.de>
References: <200409300007.29986.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409300007.29986.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 12:07:29AM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> I've obtained the following trace on a dual-Opteron box:

Someone corrupted memory. 
You could enable slab debugging, maybe that will find it earlier.

-Andi
