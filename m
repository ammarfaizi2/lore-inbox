Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVFHLIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVFHLIr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVFHLIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:08:46 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:30858 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262169AbVFHLIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:08:41 -0400
Date: Wed, 8 Jun 2005 13:08:44 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Brian Gerst <bgerst@didntduck.org>, christoph <christoph@scalex86.org>,
       Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move some more structures into "mostly_readonly"
Message-ID: <20050608110844.GD331@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw> <20050607194123.GA16637@infradead.org> <Pine.LNX.4.62.0506071258450.2850@ScMPusgw> <1118177949.5497.44.camel@laptopd505.fenrus.org> <42A61227.9090402@didntduck.org> <20050608100056.GA331@wohnheim.fh-wedel.de> <1118225246.5655.16.camel@laptopd505.fenrus.org> <20050608102053.GC331@wohnheim.fh-wedel.de> <1118226933.5655.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1118226933.5655.19.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 June 2005 12:35:33 +0200, Arjan van de Ven wrote:
> 
> I agree, and it would be very useful to have a debug option in the
> kernel that say checksums rodata (and probably the kernel text which is
> also read only) periodically and raises an alarm if the checksum
> changes. 

Not really.  You want to catch the bad guy in the act.  A bit later
isn't much better than a lot later.

Lacking the mainframe key stores, I guess the best thing is to keep
.rodata under read-only tlbs.

Jörn

-- 
Sometimes, asking the right question is already the answer.
-- Unknown
