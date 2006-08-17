Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWHQRkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWHQRkm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 13:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWHQRkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 13:40:42 -0400
Received: from smtp-out.google.com ([216.239.45.12]:45485 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932412AbWHQRkl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 13:40:41 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=CoCPS5KD0qV1CucIOhwNvtWS2Vvufzrps1eYrnZl0xxjcMW4V3kz/vYoaGe+rzqqQ
	lwbBlBt9lulYzXslIoxnA==
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1155835401.9274.64.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
	 <1155758369.9274.26.camel@localhost.localdomain>
	 <1155774274.15195.3.camel@localhost.localdomain>
	 <1155824788.9274.32.camel@localhost.localdomain>
	 <1155835003.14617.45.camel@galaxy.corp.google.com>
	 <1155835401.9274.64.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Google Inc
Date: Thu, 17 Aug 2006 10:36:38 -0700
Message-Id: <1155836198.14617.61.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 10:23 -0700, Dave Hansen wrote:
> On Thu, 2006-08-17 at 10:16 -0700, Rohit Seth wrote:
> > > That said, it sure is simpler to implement, so I'm all for it!
> > 
> > hmm, not sure why it is simpler.
> 
> When you ask the question, "which container owns this page?", you don't
> have to look far, 

as in page->mapping->container for user land?

> nor is it ambiguous in any way.  It is very strict,
> and very straightforward.


What additional ambiguity you have when inode or task structures have
the required information.

-rohit

