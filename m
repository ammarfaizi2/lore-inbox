Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUJAUK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUJAUK7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUJAUIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:08:15 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:15951 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266245AbUJAUHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:07:05 -0400
Date: Fri, 1 Oct 2004 21:06:44 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Badari Pulavarty <pbadari@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm4 ps hang ?
In-Reply-To: <20041001120926.4d6f58d5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0410012102510.9068-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2004, Andrew Morton wrote:
> 
> hm.  I can see that access_process_vm() is doing lock_page() inside
> mmap_sem, which is a ranking bug, but it's not that.

lock_page inside mmap_sem a ranking bug?  Please recant!

Hugh

