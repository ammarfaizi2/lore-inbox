Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVCBXNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVCBXNm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVCBXLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:11:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62114 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261269AbVCBXE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:04:59 -0500
Date: Wed, 2 Mar 2005 18:04:55 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050302230455.GA10124@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 02:21:38PM -0800, Linus Torvalds wrote:
 > 
 > This is an idea that has been brewing for some time: Andrew has mentioned
 > it a couple of times, I've talked to some people about it, and today Davem
 > sent a suggestion along similar lines to me for 2.6.12.
 > 
 > Namely that we could adopt the even/odd numbering scheme that we used to 
 > do on a minor number basis, and instead of dropping it entirely like we 
 > did, we could have just moved it to the release number, as an indication 
 > of what was the intent of the release.

Random ideas.  Why not use the already established 2.6.x.y method ? 
This allows development to continue on 2.6.x+1, and if needed, you
should be able to bk pull the 2.6.x.y[n] tree(s) into 2.6.x+1 no ?

My concern about this 'stable kernel every other release' method is
that if a particular development cycle drags on for some reason,
and certain bugs never got fixed in the previous release,
that's a long time users have to wait until they get things fixed.

It's somewhat akin to the problem with the infrequent out-of-tree merges
that some subsystem maintainers have. If the latest push they do
doesn't fix your bug, you typically have to wait until the next
release until they do another push.

		Dave

