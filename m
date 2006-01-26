Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWAZEIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWAZEIM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 23:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWAZEIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 23:08:12 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:39885 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932249AbWAZEIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 23:08:10 -0500
Date: Wed, 25 Jan 2006 22:06:58 -0600
From: Robin Holt <holt@sgi.com>
To: Ray Bryant <raybry@mpdtxmail.amd.com>
Cc: Dave McCracken <dmccr@us.ibm.com>, Robin Holt <holt@sgi.com>,
       Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
Message-ID: <20060126040658.GB30374@lnx-holt.americas.sgi.com>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]> <200601251648.58670.raybry@mpdtxmail.amd.com> <F6EF7D7093D441B7655A8755@[10.1.1.4]> <200601251858.11167.raybry@mpdtxmail.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601251858.11167.raybry@mpdtxmail.amd.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 06:58:10PM -0600, Ray Bryant wrote:
> Dave,
> 
> Hmph.... further analysis shows that the situation is a more complicated than 
> described in my last note, lets compare notes off-list and see what 
> conclusions, if any, we can come to.

Why off-list.  I think the munmap() or mmap() in the middle cases are
interesting.  I was hoping Dave's test program has those cases in
there as well as mapping of hugetlbfs files.  If you do take this off-list,
I would like to ride along ;)

Thanks,
Robin
