Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWDLJQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWDLJQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 05:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWDLJQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 05:16:50 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:47752 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751011AbWDLJQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 05:16:50 -0400
Message-ID: <443CC586.6060105@de.ibm.com>
Date: Wed, 12 Apr 2006 11:16:54 +0200
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: carsteno@de.ibm.com
Organization: IBM Deutschland
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, bjorn_helgaas@hp.com
Subject: Re: [patch] do_no_pfn handler
References: <yq0k6a6uc7i.fsf@jaguar.mkp.net> <yq0psjonq2p.fsf@jaguar.mkp.net>	<Pine.LNX.4.64.0604110751510.10745@g5.osdl.org> <yq0slojtb22.fsf@jaguar.mkp.net>
In-Reply-To: <yq0slojtb22.fsf@jaguar.mkp.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> Linus> At the very least, it would also need a
> Linus> 	BUG_ON(is_cow_mapping(vma->vm_flags));
> 
> Added - I am not sure how this will affect Carsten's situation based
> on the further discussion in this thread, however if something changes
> at that point I assume we can modify the limitation at a later stage.
Fine with me.
