Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265916AbUGHIYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbUGHIYA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 04:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUGHIYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 04:24:00 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:49323 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265916AbUGHIX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 04:23:59 -0400
Message-ID: <40ED049B.2020406@yahoo.com.au>
Date: Thu, 08 Jul 2004 18:23:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
References: <m2brir9t6d.fsf@telia.com>	<40ECADF8.7010207@yahoo.com.au>	<m2fz82hq8c.fsf@telia.com> <20040708012005.6232a781.akpm@osdl.org>
In-Reply-To: <20040708012005.6232a781.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Peter Osterlund <petero2@telia.com> wrote:

>>Doesn't help. My test program still fails in the same way.
>>
> 
> 
> Something odd is happening - I've run that testcase in various shapes and
> forms a huge number of times.
> 
> What filesystems are in use?  Is there anything unusual about the setup? 
> Do earlier 2.6 kernels exhibit the same problem?  Is something wrong with
> the disk system?
> 

Also, have you changed /proc/sys/vm/swappiness?
