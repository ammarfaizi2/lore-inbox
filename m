Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUGIA5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUGIA5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 20:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUGIA5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 20:57:13 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:56667 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262080AbUGIA5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 20:57:12 -0400
Message-ID: <40EDED5D.80605@yahoo.com.au>
Date: Fri, 09 Jul 2004 10:57:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
References: <m2brir9t6d.fsf@telia.com> <40ECADF8.7010207@yahoo.com.au> <20040708023001.GN21066@holomorphy.com> <m2briq7izk.fsf@telia.com> <20040708193956.GO21066@holomorphy.com>
In-Reply-To: <20040708193956.GO21066@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III <wli@holomorphy.com> writes:
> 
>>>Heh, one goes in while I'm not looking, and look what happens.
> 
> 
> On Thu, Jul 08, 2004 at 02:59:11PM +0200, Peter Osterlund wrote:
> 
>>Actually, the failure is caused by this change:
>>http://linux.bkbits.net:8080/linux-2.5/cset@40db004cKFYB35xMHcRXNijl81BLag?nav=index.html|ChangeSet@-3w
>>It only fails when /proc/sys/vm/laptop_mode is 1.
> 
> 
> Oh, then I'm stuck in the GFP_WIRED quagmire after all. I guess since
> fixing it involves adding lines I'm in deep trouble.
> 

Or just see if you can tighten up the conditions for OOM to
start with?
