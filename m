Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268730AbUIGXFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268730AbUIGXFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 19:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268727AbUIGXFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 19:05:44 -0400
Received: from holomorphy.com ([207.189.100.168]:10403 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268730AbUIGXFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 19:05:32 -0400
Date: Tue, 7 Sep 2004 16:05:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] mark install_page static
Message-ID: <20040907230524.GT3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <2E70CD2670F@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E70CD2670F@vcnet.vc.cvut.cz>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Sep 04 at 16:37, Christoph Hellwig wrote:
>> Not used anywhere in modules and it really shouldn't either.

On Tue, Sep 07, 2004 at 07:46:33PM +0200, Petr Vandrovec wrote:
> How are modules supposed to implement vma's populate method
> without having install_page available?  And yes, there are
> out of tree kernel modules which prefer fremap & populate & install_page
> over creating several thousands of VMAs to get non-linear mappings.

I think this is serious enough to keep the export.


-- wli
