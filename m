Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbVLLDqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVLLDqt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 22:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbVLLDqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 22:46:49 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:63872 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751071AbVLLDqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 22:46:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=S0OGEtasU2Y5SY1YTbpbPOZHm4j9MDBep30VEMUQI+eQzAaw5t3aS3fhScNUeJQyCrMamRRv+c4kmShRdbviarH8lDxMuXSJg0g3/fCr0kDBQUg+hz3dVNOXzbo8oURGiz/RXfzyS0A7UCwul5SST3JVedPIWsNRrXHpnuZruBo=  ;
Message-ID: <439CF2A2.60105@yahoo.com.au>
Date: Mon, 12 Dec 2005 14:46:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/6] Framework
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com> <20051210005445.3887.94119.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051210005445.3887.94119.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

> +/*
> + * For use when we know that interrupts are disabled.
> + */
> +static inline void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item, int delta)
> +{

Before this goes through, I have a full patch to do similar for the
rest of the statistics, and which will make names consistent with what
you have (shouldn't be a lot of clashes though).

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
