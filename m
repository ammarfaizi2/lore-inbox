Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWDLGtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWDLGtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 02:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWDLGtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 02:49:17 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:25109 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932078AbWDLGtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 02:49:17 -0400
Message-ID: <443CA47E.4070809@sw.ru>
Date: Wed, 12 Apr 2006 10:55:58 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Kir Kolyshkin <kir@openvz.org>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, sam@vilain.net,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, herbert@13thfloor.at
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <1143228339.19152.91.camel@localhost.localdomain>	<200603282029.AA00927@bbb-jz5c7z9hn9y.digitalinfra.co.jp>	<4429A17D.2050506@openvz.org> <443151B4.7010401@tmr.com>	<443B873B.9040908@sw.ru> <p73mzer4bti.fsf@bragg.suse.de>
In-Reply-To: <p73mzer4bti.fsf@bragg.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Moreover, in OpenVZ live migration allows to migrate 32bit VPSs
>>between i686 and x86-64 Linux machines.

> How would that work when x86-64 32bit programs have 4GB of address
> space and native on i386 programs only 3GB?
we limit address space of i386 apps on x86-64 to 3GB due to 
compatibility issues - some applications don't work with not 3:1 GB VM 
split.

On the other hand if you need 4GB addr space for user you can use 4GB 
x8664 and 4gb split on i386.

Thanks,
Kirill


