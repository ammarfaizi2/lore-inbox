Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265531AbUEZMUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUEZMUk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265538AbUEZMUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:20:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45219 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265531AbUEZMTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:19:39 -0400
Date: Wed, 26 May 2004 08:19:34 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Buddy Lumpkin <b.lumpkin@comcast.net>
cc: "'William Lee Irwin III'" <wli@holomorphy.com>, <orders@nodivisions.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
In-Reply-To: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org>
Message-ID: <Pine.LNX.4.44.0405260818030.30062-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004, Buddy Lumpkin wrote:

> No. I am not making any assertions whatsoever. I am just calling out
> that systems that run happily from physical memory and are not in need
> of swap should never sacrifice an ounce of performance

Executables and shared libraries live in the filesystem
cache.  Evicting those from memory - because swapping is
disabled and "the VM should remove something from cache
instead" - will feel exactly the same as swapping ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

