Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271969AbTHEVN3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 17:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271970AbTHEVN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 17:13:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41624 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271969AbTHEVNY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 17:13:24 -0400
Message-ID: <3F301DDC.2050502@pobox.com>
Date: Tue, 05 Aug 2003 17:13:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] revert to static = {0}
References: <20030805174429.GA26933@gtf.org> <Pine.LNX.4.44.0308051949130.1849-100000@localhost.localdomain> <20030805190659.GT32488@holomorphy.com>
In-Reply-To: <20030805190659.GT32488@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Tue, 5 Aug 2003, Jeff Garzik wrote:
> 
>>>If it's const, it shouldn't be linked into anything at all... right?
> 
> 
> On Tue, Aug 05, 2003 at 07:51:41PM +0100, Hugh Dickins wrote:
> 
>>Sorry, Jeff, I don't get your point.
> 
> 
> I suspect this assumes const values will get constant folded, which I'm
> not sure is the case, though it certainly sounds legal and worthwhile
> for a compiler to do when reasonable (i.e. for small structures and/or
> extractions of small fields of const structures).


Correct.  In fact, some Linux kernel code _assumes_ the compiler will 
fold constants...

	Jeff



