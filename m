Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263821AbTDDQ1a (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 11:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbTDDQTM (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 11:19:12 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:22728 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263808AbTDDQQM (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 11:16:12 -0500
Date: Fri, 4 Apr 2003 17:29:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@digeo.com>, Dave McCracken <dmccr@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: objrmap and vmtruncate
In-Reply-To: <20030404161457.GE993@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0304041725240.1970-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Apr 2003, William Lee Irwin III wrote:
> 
> Hmm, aren't the file offset calculations wrong for sys_remap_file_pages()
> even before objrmap?

Yes - objrmap merely makes it difficult to find the missed pages later on.

