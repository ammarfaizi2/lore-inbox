Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263045AbUEKGiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbUEKGiB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUEKGgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:36:15 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:20997 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262106AbUEKGXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:23:33 -0400
Date: Tue, 11 May 2004 07:23:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Wim Coekaerts <wim.coekaerts@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040511072329.D12187@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Wim Coekaerts <wim.coekaerts@oracle.com>,
	Andrew Morton <akpm@osdl.org>, cw@f00f.org,
	linux-kernel@vger.kernel.org
References: <20040510150203.3257ccac.akpm@osdl.org> <20040510231146.GA5168@taniwha.stupidest.org> <20040510162818.376b4a55.akpm@osdl.org> <20040510233342.GA5614@taniwha.stupidest.org> <20040510165132.5107472e.akpm@osdl.org> <20040510235312.GA9348@taniwha.stupidest.org> <20040510171413.6c1699b8.akpm@osdl.org> <20040511002426.GD1105@ca-server1.us.oracle.com> <20040510181008.1906ea8a.akpm@osdl.org> <20040511015118.GA4589@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040511015118.GA4589@ca-server1.us.oracle.com>; from wim.coekaerts@oracle.com on Mon, May 10, 2004 at 06:51:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 06:51:18PM -0700, Wim Coekaerts wrote:
> > err, so why did I just merge the hugetlb_shm_group patch?
> 
> because of what you mentioned. it takes a long time before that goes
> out, it's not even tested, and it doesn't apply to those 1000's of
> existing systems taht will break on upgrade.   exactly what you said, it
> makes it possible to get to a different way smoothly in time. my
> comments were not "we can use it today".

So it's a hack for legacy oracle versions.  nice.  and for that we
introduce completely alien concepts like magic groups into the kernel..

