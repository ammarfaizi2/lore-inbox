Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264065AbTDJPHq (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 11:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbTDJPHp (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 11:07:45 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:8511 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S264065AbTDJPHp (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 11:07:45 -0400
Date: Thu, 10 Apr 2003 16:21:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix obj vma sorting
In-Reply-To: <211120000.1049986657@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0304101618570.1873-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Apr 2003, Martin J. Bligh wrote:
> 
> Eeek. There's no way we can set this up to do it as two separate VMAs
> initially, is there?

What if we could?  It's already shown the VMA sorting is (liable to be)
too slow.  Changing that most common case won't change the fact.

Hugh

