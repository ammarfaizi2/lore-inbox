Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758882AbWLEFyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758882AbWLEFyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758890AbWLEFyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:54:39 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:32425 "HELO
	smtp107.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758882AbWLEFyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:54:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=iMnib8E7p5og17+UP1ykeUgMI+IN9ae8ViVbxxcJwai0/z23D+Dlx9sdJxLsMA19JFnaDlmkPrQtDFIPOQ4P+En2p3robC5Cl9SRWw/1NvQbJLs7Sm6h1QukrgNd77AAlqHZid8Mf9IKBsIkd8Lp4mEWlNEcToDncCtpJv0p39M=  ;
X-YMail-OSG: 9tOtD9IVM1mERnHpZEYjNcMqg9woAuc_NU9FCrSCspXMzstmVvOCOJR35_SZlzjd1rnO7x5g526omooClr44YiM2ohx1YvJrakOarpzBT7bRK79ZzkAyWbUkdMIFmR2ukLRtH.2OsHUCnw--
Message-ID: <4575096F.1030603@yahoo.com.au>
Date: Tue, 05 Dec 2006 16:53:51 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
References: <20061204204024.2401148d.akpm@osdl.org>	<17781.27.369430.322758@cargo.ozlabs.ibm.com> <20061204214229.2070548a.akpm@osdl.org>
In-Reply-To: <20061204214229.2070548a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 5 Dec 2006 16:14:03 +1100
> Paul Mackerras <paulus@samba.org> wrote:
> 
> 
>>>radix-tree-rcu-lockless-readside.patch
>>>
>>> There's no reason to merge this yet.
>>
>>We want to use it in some powerpc arch code.  Currently we use a
>>per-cpu array of spinlocks, and this patch would let us get rid of
>>that array.
> 
> 
> ok, let's merge it then.

Well that wasn't as hard as I thought ;) No arguments from me!

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
