Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264051AbTDJOZ2 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 10:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264053AbTDJOZ1 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 10:25:27 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:16828 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S264051AbTDJOZ0 (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 10:25:26 -0400
Date: Thu, 10 Apr 2003 15:39:02 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@digeo.com>, Dave McCracken <dmccr@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix obj vma sorting
In-Reply-To: <208780000.1049984941@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0304101536500.1788-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Apr 2003, Martin J. Bligh wrote:
> 
> Yeah, sorry ... I guess someone should have published the phone conversation
> we had yesterday ... </me pokes Dave in the eye>

No problem: I left you all hanging.

> We came to the conclusion that should be adding the semaphore to the current 
> code even, as list_add_tail isn't atomic to a doubly linked list

Sure you can't list_add_tail without the semaphore: where is it missed?

Hugh

