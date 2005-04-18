Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVDRUBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVDRUBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 16:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVDRUBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 16:01:15 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:55972 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262190AbVDRUBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 16:01:14 -0400
Message-ID: <426411C2.5040703@ammasso.com>
Date: Mon, 18 Apr 2005 15:00:02 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Roland Dreier <roland@topspin.com>, Troy Benjegerdes <hozer@hozed.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>	 <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>	 <4263DBBF.9040801@ammasso.com>	 <1113840973.6274.84.camel@laptopd505.fenrus.org>	 <4263DF70.2060702@ammasso.com> <1113853240.6274.99.camel@laptopd505.fenrus.org>
In-Reply-To: <1113853240.6274.99.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> you should since that physical page can be reused, say by a root
> process, and you'd be majorly screwed

I don't understand what you mean by "reused".  The whole point behind pinning the memory 
is that it stays where it is.  It doesn't get moved around and it doesn't get swapped out.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com
