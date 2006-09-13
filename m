Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWIMRyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWIMRyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 13:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWIMRyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 13:54:46 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:25449 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750851AbWIMRyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 13:54:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=tenPvnS47rTYuqmT7p6FA8D21nq/K+e2H8EbNQEGGklcivgjkDPJzT9SE/sAmPm2p0Z2vYaTU5g35xyTd71fEvL27UCmOcwv6x+gvXkwVZBsA7uKaIKzTNvFz+3XxBMg3Ivd4gha4cMC39SpnvDGziRCdl2Kb7Q6nMVRUePjMyw=  ;
Message-ID: <450845CC.6000402@yahoo.com.au>
Date: Thu, 14 Sep 2006 03:54:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: Why Semaphore Hardware-Dependent?
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <44F395DE.10804@yahoo.com.au> <200608290807.40963.ak@suse.de>
In-Reply-To: <200608290807.40963.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry, I missed some emails when I was out of action a while back. Catching up...]

Andi Kleen wrote:
>>and chuck out the "crappy" rwsem fallback implementation
> 
> 
> What is crappy with it?

I just mean that it is supposedly the second class implementation. Just
seems wrong when powerpc has implemented the "better" version in a completely
generic way (patch to follow).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
