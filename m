Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVFHKVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVFHKVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 06:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVFHKVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 06:21:04 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:389 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262106AbVFHKUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 06:20:55 -0400
Date: Wed, 8 Jun 2005 12:20:53 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Brian Gerst <bgerst@didntduck.org>, christoph <christoph@scalex86.org>,
       Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move some more structures into "mostly_readonly"
Message-ID: <20050608102053.GC331@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw> <20050607194123.GA16637@infradead.org> <Pine.LNX.4.62.0506071258450.2850@ScMPusgw> <1118177949.5497.44.camel@laptopd505.fenrus.org> <42A61227.9090402@didntduck.org> <20050608100056.GA331@wohnheim.fh-wedel.de> <1118225246.5655.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1118225246.5655.16.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 June 2005 12:07:25 +0200, Arjan van de Ven wrote:
> On Wed, 2005-06-08 at 12:00 +0200, Jörn Engel wrote:
> > On Tue, 7 June 2005 17:31:19 -0400, Brian Gerst wrote:
> > > 
> > > It doesn't really matter.  .rodata isn't actually mapped read-only. 
> > > Doing so would break up the large pages used to map the kernel.
> > 
> > Can you confirm that for every architecture?  Or just i386?
> 
> does it matter? it's supposed to be read only, only sometimes that's not
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> enforced unfortunately.

I agree.  What I don't agree with is "It doesn't really matter" - not
after debugging the occasional memory corruptions.

Jörn

-- 
The grand essentials of happiness are: something to do, something to
love, and something to hope for.
-- Allan K. Chalmers
