Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVCaEpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVCaEpO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 23:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVCaEpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 23:45:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3817 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261946AbVCaEpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 23:45:07 -0500
Message-ID: <424B8045.7040308@pobox.com>
Date: Wed, 30 Mar 2005 23:44:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, sean <seandarcy2@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BK snapshots removed from kernel.org?
References: <200503271414.33415.nbensa@gmx.net> <20050327210218.GA1236@ip68-4-98-123.oc.oc.cox.net> <200503281226.48146.nbensa@gmx.net> <4248258A.1060604@osdl.org> <d2fr2e$lvo$1@sea.gmane.org> <424B72CC.8030801@osdl.org> <424B79E6.90300@pobox.com> <20050331042923.GB23124@redhat.com>
In-Reply-To: <20050331042923.GB23124@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Wed, Mar 30, 2005 at 11:17:42PM -0500, Jeff Garzik wrote:
>  > >with the requirement (for me) that I not be required to use BK?
>  > >I'll munge scripts or whatever...
>  > >but I guess that I'll also need a kernel.org account to do that.
>  > 
>  > Should hopefully just be changing get-version.pl ...
> 
> hmm, it's going to go a bit nutso when it finds the most
> recent TAG: is from the bk pull of 2.6.11.x into Linus tree.
> So it generates -bk from /that/ instead of 2.6.12.

Correct (your description, not the code...), that is the problem that 
causes snapshots to go bonkers.


> Could hack around it by checking the cset is from Linus I suppose ?

Probably best just to parse the Makefile, since TAG is no longer a valid 
indicator.


>  > 	Jeff, still catching up from trip+engagement
> 
> Congrats!

Thanks!

	Jeff


