Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268131AbUIGPNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268131AbUIGPNR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268229AbUIGPKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:10:35 -0400
Received: from verein.lst.de ([213.95.11.210]:32154 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268330AbUIGPGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:06:37 -0400
Date: Tue, 7 Sep 2004 17:06:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@verein.lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unexport files_lock and put_filp
Message-ID: <20040907150633.GB9322@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040907150600.GA9322@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907150600.GA9322@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 05:06:00PM +0200, Christoph Hellwig wrote:
> rather lowlevel functions that modules shouldn't mess with and

Umm, file_list_lock is of course not a function but a global lock
variable - even worse.

