Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWDTXjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWDTXjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWDTXjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:39:03 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:47590 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751282AbWDTXjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:39:02 -0400
Date: Fri, 21 Apr 2006 08:38:45 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch: 001/006] pgdat allocation for new node add (specify node id)
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20060420154956.1aa4acbe.akpm@osdl.org>
References: <20060420190338.EE4A.Y-GOTO@jp.fujitsu.com> <20060420154956.1aa4acbe.akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060421083415.FCF2.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
> >
> > +int add_memory(int nid, u64 start, u64 size)
> >  +{
> >  +	int ret;
> >  +
> >  +	/* call arch's memory hotadd */
> >  +	ret = arch_add_memory(nid, start, size;
> >  +
> >  +	return ret;
> >  +}
> 
> So this patch is missing a ), but your later patch which touches this code
> actually has the ).  Which tells me that this isn't the correct version of
> this patch.
> 
> I'll fix that all up, but I would ask you to carefully verify that the
> patches which I merged are the ones which you meant to send, thanks.

Oops. I thought I fixed it, but I made mistake.
Sorry.

-- 
Yasunori Goto 


