Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932862AbWCVWaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932862AbWCVWaz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932866AbWCVWaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:30:55 -0500
Received: from cantor.suse.de ([195.135.220.2]:39653 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932862AbWCVWay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:30:54 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC, PATCH 1/24] i386 Vmi documentation II
Date: Wed, 22 Mar 2006 22:39:44 +0100
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
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com> <200603222105.58912.ak@suse.de>
In-Reply-To: <200603222105.58912.ak@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603222239.46604.ak@suse.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There was one other point I wanted to make but I forgot it now @)

Ah yes the point was that since most of the implementations of the hypercalls
likely need fast access to some per CPU state. How would you plan
to implement that? Should it be covered in the specification?

-Andi
