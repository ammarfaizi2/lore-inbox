Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWCOUxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWCOUxk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 15:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWCOUxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 15:53:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64726 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750710AbWCOUxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 15:53:39 -0500
To: Zachary Amsden <zach@vmware.com>
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
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH 21/24] i386 Vmi proc node
References: <200603131815.k2DIFPa7005772@zach-dev.vmware.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 15 Mar 2006 13:49:58 -0700
In-Reply-To: <200603131815.k2DIFPa7005772@zach-dev.vmware.com> (Zachary
 Amsden's message of "Mon, 13 Mar 2006 10:15:25 -0800")
Message-ID: <m1k6avxwjt.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden <zach@vmware.com> writes:

> Add a /proc node for the VMI sub-arch, which gives information on the VMI ROM
> detected using /proc/vmi/info and a list of kernel annotations in
> /proc/vmi/annotations.
>
> The timing information is VMware specific, and should probably be put into a
> separate /proc node (and a separate patch for our internal use).

No new non process local files in proc please.

Eric
