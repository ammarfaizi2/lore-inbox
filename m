Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbULLV3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbULLV3l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 16:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbULLV1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 16:27:40 -0500
Received: from holomorphy.com ([207.189.100.168]:21668 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262136AbULLVZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 16:25:30 -0500
Date: Sun, 12 Dec 2004 13:24:56 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance tests
Message-ID: <20041212212456.GB2714@holomorphy.com>
References: <41BBF923.6040207@yahoo.com.au> <Pine.LNX.4.44.0412120914190.3476-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0412120914190.3476-100000@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2004 at 09:33:11AM +0000, Hugh Dickins wrote:
> Oh, hold on, isn't handle_mm_fault's pmd without page_table_lock
> similarly racy, in both the 64-on-32 cases, and on architectures
> which have a more complex pmd_t (sparc, m68k, h8300)?  Sigh.

yes.


-- wli
