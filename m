Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWIHJMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWIHJMY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 05:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWIHJMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 05:12:23 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:38608 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1750737AbWIHJMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 05:12:22 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Fernando Vazquez <fernando@oss.ntt.co.jp>,
       "David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, stable@kernel.org, xemul@openvz.org,
       devel@openvz.org
Subject: Re: [PATCH] IA64,sparc: local DoS with corrupted ELFs
References: <44FC193C.4080205@openvz.org>
	<Pine.LNX.4.64.0609061120430.27779@g5.osdl.org>
	<20060906182733.GJ2558@parisc-linux.org>
	<1157569579.29093.51.camel@laptopd505.fenrus.org>
From: Jes Sorensen <jes@sgi.com>
Date: 08 Sep 2006 05:12:21 -0400
In-Reply-To: <1157569579.29093.51.camel@laptopd505.fenrus.org>
Message-ID: <yq0lkouhgcq.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Arjan" == Arjan van de Ven <arjan@infradead.org> writes:

Arjan> On Wed, 2006-09-06 at 12:27 -0600, Matthew Wilcox wrote:
>> On Wed, Sep 06, 2006 at 11:24:05AM -0700, Linus Torvalds wrote: >
>> If MIPS and parisc don't matter for the stable tree (very possible
>> - there > are no big commercial distributions for them), then
>> dammit, neither should > ia64 and sparc (there are no big
>> commercial distros for them either).
>> 
>> Erm, RHEL and SLES both support ia64.

Arjan> but neither use -stable.

And getting a patch into -stable tends to be a really good argument
for a backport into the next vendor kernel :)

Cheers,
Jes
