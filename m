Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWHQRYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWHQRYG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 13:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWHQRYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 13:24:06 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:47799 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030187AbWHQRYE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 13:24:04 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Dave Hansen <haveblue@us.ibm.com>
To: rohitseth@google.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1155835003.14617.45.camel@galaxy.corp.google.com>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
	 <1155758369.9274.26.camel@localhost.localdomain>
	 <1155774274.15195.3.camel@localhost.localdomain>
	 <1155824788.9274.32.camel@localhost.localdomain>
	 <1155835003.14617.45.camel@galaxy.corp.google.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 10:23:21 -0700
Message-Id: <1155835401.9274.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 10:16 -0700, Rohit Seth wrote:
> > That said, it sure is simpler to implement, so I'm all for it!
> 
> hmm, not sure why it is simpler.

When you ask the question, "which container owns this page?", you don't
have to look far, nor is it ambiguous in any way.  It is very strict,
and very straightforward.

-- Dave

