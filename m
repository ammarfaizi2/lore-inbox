Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263092AbUCXIbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 03:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbUCXIbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 03:31:44 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:31443 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263092AbUCXIbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 03:31:41 -0500
Date: Wed, 24 Mar 2004 08:31:42 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-aa2
In-Reply-To: <20040324060020.GA2065@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403240831001.6413-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2004, Andrea Arcangeli wrote:
> 
> BTW, I put the set_page_dirty back into the page_map_lock because we've
> to run that under the page_map_lock anyways if the pte was dirty during
> swapping/paging. I mean, as far as we run it there, then we can run it
> in the other s390-only places too.

Of course.  Silly me.  Sorry for wasting your time on that.

Hugh

