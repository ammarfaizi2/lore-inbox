Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264979AbUELFn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264979AbUELFn1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 01:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265017AbUELFn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 01:43:27 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:8465 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264979AbUELFnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 01:43:08 -0400
Date: Wed, 12 May 2004 06:42:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Wim Coekaerts <wim.coekaerts@oracle.com>, torvalds@transmeta.com
Cc: hch@infradead.org, Andrew Morton <akpm@osdl.org>, cw@f00f.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040512064253.A25250@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Wim Coekaerts <wim.coekaerts@oracle.com>, torvalds@transmeta.com,
	Andrew Morton <akpm@osdl.org>, cw@f00f.org,
	linux-kernel@vger.kernel.org
References: <20040510231146.GA5168@taniwha.stupidest.org> <20040510162818.376b4a55.akpm@osdl.org> <20040510233342.GA5614@taniwha.stupidest.org> <20040510165132.5107472e.akpm@osdl.org> <20040510235312.GA9348@taniwha.stupidest.org> <20040510171413.6c1699b8.akpm@osdl.org> <20040511002426.GD1105@ca-server1.us.oracle.com> <20040510181008.1906ea8a.akpm@osdl.org> <20040511015118.GA4589@ca-server1.us.oracle.com> <20040511151206.GK11353@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040511151206.GK11353@ca-server1.us.oracle.com>; from wim.coekaerts@oracle.com on Tue, May 11, 2004 at 08:12:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 08:12:07AM -0700, Wim Coekaerts wrote:
> oh and for what it's worth, I didn't like the shmgid solution either, I
> brought up rlmits first iirc. if there is something better great, but as
> that was not going anywhere and this is... 
> 
> let's see if wli can make things work correctly with physdical pages
> with rlmits and go from there.

Okay, so can we please remove the half-backed non-soloutions from the
tree now?  Aka, Linus please cset -x

'[PATCH] Add sysctl to define a hugetlb-capable group', current cset num
in the tree is 1.1608.6.126

