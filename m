Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVFHKBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVFHKBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 06:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVFHKBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 06:01:13 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:6275 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261201AbVFHKBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 06:01:09 -0400
Date: Wed, 8 Jun 2005 12:00:56 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Arjan van de Ven <arjan@infradead.org>, christoph <christoph@scalex86.org>,
       Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move some more structures into "mostly_readonly"
Message-ID: <20050608100056.GA331@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw> <20050607194123.GA16637@infradead.org> <Pine.LNX.4.62.0506071258450.2850@ScMPusgw> <1118177949.5497.44.camel@laptopd505.fenrus.org> <42A61227.9090402@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42A61227.9090402@didntduck.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 June 2005 17:31:19 -0400, Brian Gerst wrote:
> 
> It doesn't really matter.  .rodata isn't actually mapped read-only. 
> Doing so would break up the large pages used to map the kernel.

Can you confirm that for every architecture?  Or just i386?

Jörn

-- 
There is no worse hell than that provided by the regrets
for wasted opportunities.
-- Andre-Louis Moreau in Scarabouche
