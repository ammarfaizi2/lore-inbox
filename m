Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTJIU04 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 16:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTJIU04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 16:26:56 -0400
Received: from intra.cyclades.com ([64.186.161.6]:15534 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262456AbTJIU0z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 16:26:55 -0400
Date: Thu, 9 Oct 2003 17:19:02 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG() in exec_mmap()
In-Reply-To: <1065730208.27064.20.camel@shaggy.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0310091718080.3040-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Oct 2003, Dave Kleikamp wrote:

> Marcelo,
> A recent change to exec_mmap() removed the initialization of old_mm,
> leaving an uninitialized use of it.  This patch would completely remove
> old_mm from the function.  Is this what was intended?

Yes. 

Blame me... patch applied, thank you!

