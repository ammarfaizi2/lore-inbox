Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWCWBGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWCWBGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 20:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWCWBGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 20:06:33 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:6018 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932165AbWCWBGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 20:06:32 -0500
Date: Wed, 22 Mar 2006 17:06:27 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
Message-ID: <20060323010627.GS15997@sorel.sous-sol.org>
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <200603222115.46926.ak@suse.de> <20060322214025.GJ15997@sorel.sous-sol.org> <4421CCA8.4080702@vmware.com> <20060322225117.GM15997@sorel.sous-sol.org> <4421DF62.8020903@vmware.com> <20060323004136.GR15997@sorel.sous-sol.org> <4421F1AD.1070108@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4421F1AD.1070108@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> No, you don't need to dream up all the possible interface bits ahead of 
> time.  With a la carte interfaces, you can take what you need now, and 
> add features later.  You don't need an ABI for features.  You need it 
> for compatibility.  You will need to update the hypervisor ABI.  And you 
> can't force people to upgrade their kernels.

How do you support an interface that's not already a part of the ABI
w/out changing the kernel?
