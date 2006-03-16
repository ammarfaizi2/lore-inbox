Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751932AbWCPBRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbWCPBRw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 20:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbWCPBRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 20:17:52 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:47366 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751932AbWCPBRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 20:17:51 -0500
Message-ID: <4418BCBE.7010608@vmware.com>
Date: Wed, 15 Mar 2006 17:17:50 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 9/24] i386 Vmi smp support
References: <200603131805.k2DI5wlO005693@zach-dev.vmware.com> <20060315231755.GB1919@elf.ucw.cz>
In-Reply-To: <20060315231755.GB1919@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>   
>> @@ -0,0 +1,51 @@
>> +/* 
>> + * include/asm-i386/mach-default/smpboot_hooks.h
>> + *
>> + * Portions Copyright 2005 VMware, Inc.
>> + */
>>     
>
> Whose are the other portions?
>   

We don't know.  Most of this is copied from the generic smpboot_hooks.h, 
and most of the fixups you pointed out can be applied there as well.  
Adding to my todo list.

Zach
