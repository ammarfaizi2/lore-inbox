Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVAECHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVAECHN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVAECHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:07:13 -0500
Received: from one.firstfloor.org ([213.235.205.2]:5305 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262187AbVAECHF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:07:05 -0500
To: Ray Bryant <raybry@sgi.com>
Cc: Hirokazu Takahashi <taka@valinux.co.jp>, Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, stevel@mvista.com
Subject: Re: page migration patchset
References: <41DB35B8.1090803@sgi.com>
From: Andi Kleen <ak@muc.de>
Date: Wed, 05 Jan 2005 03:07:03 +0100
In-Reply-To: <41DB35B8.1090803@sgi.com> (Ray Bryant's message of "Tue, 04
 Jan 2005 18:32:56 -0600")
Message-ID: <m1wtusd3y0.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant <raybry@sgi.com> writes:

> http://sr71.net/patches/2.6.10/2.6.10-mm1-mhp-test7/
>
> A number of us are interested in using the page migration patchset by itself:
>
> (1)  Myself, for a manual page migration project I am working on.  (This
>       is for migrating jobs from one set of nodes to another under batch
>       scheduler control).
> (2)  Marcello, for his memory defragmentation work.
> (3)  Of course, the memory hotplug project itself.
>
> (there are probably other "users" that I have not enumerated here).

Could you coordinate that with Steve Longerbeam (cc'ed) ? 

He has a NUMA API extension ready to be merged into -mm* that also
does kind of page migration when changing the policies of files.

-Andi

