Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbUB0Vpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUB0VnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:43:11 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:52534 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263149AbUB0Vml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:42:41 -0500
Date: Fri, 27 Feb 2004 21:42:42 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Rik van Riel <riel@redhat.com>, <andrea@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
    end)
In-Reply-To: <20040227122936.4c1be1fd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0402272135400.2214-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Andrew Morton wrote:
> 
> Apart from the search problem, my main gripe with objrmap is that it
> creates different handling for file-backed and anonymous memory.  And the
> code which extends it to anonymous memory is complex and large.

I challenge that: anobjrmap ventured into more files than you wanted to
change at the time, but it was not complex, and removed more than it added.

Hugh

