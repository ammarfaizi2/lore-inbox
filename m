Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWCPW5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWCPW5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 17:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWCPW5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 17:57:40 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:14864 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964882AbWCPW5j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 17:57:39 -0500
Message-ID: <4419DE92.8010203@vmware.com>
Date: Thu, 16 Mar 2006 13:54:26 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <Pine.LNX.4.61.0603162008300.11776@yvahk01.tjqt.qr> <Pine.LNX.4.63.0603161444460.4458@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0603161444460.4458@cuia.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Thu, 16 Mar 2006, Jan Engelhardt wrote:
>
>   
>> The code _you_ wrote can be put under any license(s) you want, so in
>> the worst case you do not need to rewrite your .c files.
>>     
>
> The license might affect which other OSes could link in
> the ROM though...
>   

That's actually a hideously good point.  I think that means, in fact, 
that the ROM code specifically cannot be GPL'd - otherwise BSD might be 
unable to use it.  The LGPL might be more appropriate.

Zach

