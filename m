Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269712AbUHZWJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269712AbUHZWJR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269696AbUHZWJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:09:00 -0400
Received: from verein.lst.de ([213.95.11.210]:50401 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269721AbUHZWGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:06:08 -0400
Date: Fri, 27 Aug 2004 00:05:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Dmitry Baryshkov <mitya@school.ioffe.ru>, Hans Reiser <reiser@namesys.com>,
       Andrew Morton <akpm@osdl.org>, hch@lst.de,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>, flx@namesys.com,
       torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826220546.GA12401@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Nikita Danilov <nikita@clusterfs.com>,
	Dmitry Baryshkov <mitya@school.ioffe.ru>,
	Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>, flx@namesys.com,
	torvalds@osdl.org, reiserfs-list@namesys.com
References: <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org> <412DAC59.4010508@namesys.com> <1093548414.5678.74.camel@krustophenia.net> <20040826203017.GA14361@school.ioffe.ru> <1093552692.13881.43.camel@leto.cs.pocnet.net> <16686.22336.829096.678178@thebsh.namesys.com> <1093556818.13881.75.camel@leto.cs.pocnet.net> <16686.24120.761440.969273@thebsh.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16686.24120.761440.969273@thebsh.namesys.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 02:03:36AM +0400, Nikita Danilov wrote:
>  > What about fs/reiser4/plugin/node/ and fs/reiser4/plugin/disk_format/?
>  > 
>  > Of course you can implement another filesystem inside the plugins but
>  > they wouldn't use fs/reiser4/*.c, so this would be rather stupid. Right?
>  > 
> 
> That was the message of my message.

And I think Christophe and me already agreed in this thread that these
upper level plugin facility should go away before merge anyway.  We made
the mistake of not requesting removel of that one for XFS and now SGI
blocks it's removal.

