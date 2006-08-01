Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWHAVcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWHAVcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWHAVcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:32:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:28598 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750984AbWHAVcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:32:17 -0400
Date: Tue, 1 Aug 2006 14:31:21 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Chris Wright <chrisw@sous-sol.org>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Gerd Hoffmann <kraxel@suse.de>, Hollis Blanchard <hollisb@us.ibm.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       npiggin@suse.de, Ian Wienand <ianw@gelato.unsw.edu.au>
Subject: Re: [PATCH 1 of 13] Add apply_to_page_range() which applies a function
 to a pte range
In-Reply-To: <20060801211410.GH2654@sequoia.sous-sol.org>
Message-ID: <Pine.LNX.4.64.0608011421080.19146@schroedinger.engr.sgi.com>
References: <79a98a10911fc4e77dce.1154421372@ezr.goop.org>
 <m1ejw0zmic.fsf@ebiederm.dsl.xmission.com> <20060801211410.GH2654@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006, Chris Wright wrote:

> We got the opposite feedback the first time we posted this function.
> Xen has some users, and I believe there's a couple in-tree functions we could
> convert easily w/out overhead issues.  It's generic and this is just the
> infrastructure, I think we should leave it.

Th generic method was proposed a number of times in the past including 
by Nick Piggin and more recently by the page table abstraction layer 
posted by Ian Wienand. See also 

http://www.gelato.org/pdf/apr2006/gelato_ICE06apr_unsw.pdf
http://www.gelato.org/pdf/may2005/gelato_may2005_ia64vm_chubb_unsw.pdf.
http://lwn.net/Articles/124961/

Special functionality may be attached at various levels, and we are very 
sensitive to changes in this area.

Would you please research this issue thoroughly and coordinate with others 
who have the same interest?
