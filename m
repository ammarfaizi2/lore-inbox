Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVADOHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVADOHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 09:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVADOHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 09:07:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:233 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261651AbVADOGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 09:06:42 -0500
Date: Tue, 4 Jan 2005 09:06:24 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: Adam Heath <doogie@brainfood.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "xen-devel@lists.sf.net" <xen-devel@lists.sourceforge.net>
Subject: Re: [Xen-devel] Re: [XEN] using shmfs for swapspace
In-Reply-To: <20050104093044.GC10906@lkcl.net>
Message-ID: <Pine.LNX.4.61.0501040905460.25392@chimarrao.boston.redhat.com>
References: <20050102162652.GA12268@lkcl.net> <20050103183133.GA19081@samarkand.rivenstone.net>
 <20050103205318.GD6631@lkcl.net> <Pine.LNX.4.58.0501031506080.21792@gradall.private.brainfood.com>
 <20050104093044.GC10906@lkcl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Luke Kenneth Casson Leighton wrote:

> then that tends to suggest that this is an issue that should
> really be dealt with by XEN.

Probably.

> that there needs to be coordination of swap management between the
> virtual machines.

I'd like to see the maximum security separation possible
between the unprivileged guests, though...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
