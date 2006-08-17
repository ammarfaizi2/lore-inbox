Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWHQOjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWHQOjq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWHQOjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:39:46 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:26789 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932538AbWHQOjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:39:44 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: rohitseth@google.com, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E46ED3.7000201@sw.ru>
References: <44E33893.6020700@sw.ru> <44E33C8A.6030705@sw.ru>
	 <1155752693.22595.76.camel@galaxy.corp.google.com> <44E46ED3.7000201@sw.ru>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 07:38:13 -0700
Message-Id: <1155825493.9274.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 17:27 +0400, Kirill Korotaev wrote:
> charged kernel objects can't be _reclaimed_. how do you propose
> to reclaim tasks page tables or files or task struct or vma or etc.?

Do you have any statistics on which of these objects are the most
troublesome?  If it _is_ pagetables, for instance, it is quite
conceivable that we could reclaim them.

This one probably deserves a big, fat comment, though. ;)

-- Dave

