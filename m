Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbVLGGoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbVLGGoY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 01:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbVLGGoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 01:44:24 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:64402 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030286AbVLGGoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 01:44:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=r8FuH9jqni0zReuaaH/wJ3mpv2xMiNKsal5p/TUiwta3qc65OBRDMNanUTDiwJXGTvdXutxwQcX8EXyGXYRN+oD5ya5nSoMtxT00OPujpi6Qac3uBEp62o95IJzhdsxcHuXgo/QMz1mRwHPYD6rBCw7/Uo9LmvCQ8qkDt5T2v20=  ;
Message-ID: <439684C0.9090107@yahoo.com.au>
Date: Wed, 07 Dec 2005 17:44:16 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/3] Framework for accurate node based statistics
References: <20051206182843.19188.82045.sendpatchset@schroedinger.engr.sgi.com> <439619F9.4030905@yahoo.com.au> <Pine.LNX.4.62.0512061536001.20580@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0512061536001.20580@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 7 Dec 2005, Nick Piggin wrote:
> 
> 
>>Why not have per-node * per-cpu counters?
> 
> 
> Yes, that is exactly what this patch implements.
>  

Sorry, I think I meant: why don't you just use the "add all counters
from all per-cpu of the node" in order to find the node-statistic?

Ie. like the node based page_state statistics that we already have.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
