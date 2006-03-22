Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932722AbWCVVA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbWCVVA0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbWCVU7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:59:09 -0500
Received: from cantor2.suse.de ([195.135.220.15]:6066 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932722AbWCVU7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:59:02 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC, PATCH 3/24] i386 Vmi interface definition
Date: Wed, 22 Mar 2006 21:06:57 +0100
User-Agent: KMail/1.9.1
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
References: <200603131801.k2DI1EAe005650@zach-dev.vmware.com>
In-Reply-To: <200603131801.k2DI1EAe005650@zach-dev.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603222106.59436.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 19:01, Zachary Amsden wrote:

> +#define VMI_CALLS \

Somehow the preprocessor doesn't seem like a good way to store
information like this.

-Andi
