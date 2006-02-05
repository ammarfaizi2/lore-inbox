Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbWBEEge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbWBEEge (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 23:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWBEEge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 23:36:34 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24727 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932619AbWBEEge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 23:36:34 -0500
Date: Sat, 4 Feb 2006 20:36:17 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: penberg@cs.helsinki.fi, christoph@lameter.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       manfred@colorfullife.com
Subject: Re: [RFT/PATCH] slab: consolidate allocation paths
Message-Id: <20060204203617.f773606a.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602041941570.9005@schroedinger.engr.sgi.com>
References: <1139060024.8707.5.camel@localhost>
	<Pine.LNX.4.62.0602040709210.31909@graphe.net>
	<1139070369.21489.3.camel@localhost>
	<1139070779.21489.5.camel@localhost>
	<20060204180026.b68e9476.pj@sgi.com>
	<Pine.LNX.4.62.0602041941570.9005@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> Hmmm... Maybe its worth a retry with gcc 3.4 and 4.X? Note that the
> size increase may be much less on i386. The .o file includes descriptive
> material too...

Yes, the other gcc's will no doubt have a different amount of increase.

Yes, i386 text sizes seem to run half the size of ia64.

No, I said "text" size, not file size.  Meaning with the size command.
That same 776 byte size difference in text size showed up in the final
vmlinux, which I just verified.

This is not a 'big problem.'  It's just a curiosity, for which an
explanation might provide interesting insight to what this patch is
doing.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
