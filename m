Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbUK3XBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbUK3XBo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbUK3W7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:59:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3482 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262409AbUK3W56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:57:58 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com>
	<20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	<1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	<20041127032403.GB10536@kroah.com>
	<16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	<ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	<oract0thnj.fsf@livre.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org>
	<oris7nrq0h.fsf@livre.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0411301413260.22796@ppc970.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 30 Nov 2004 20:57:32 -0200
In-Reply-To: <Pine.LNX.4.58.0411301413260.22796@ppc970.osdl.org>
Message-ID: <or4qj7rllv.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 30, 2004, Linus Torvalds <torvalds@osdl.org> wrote:

> On Tue, 30 Nov 2004, Alexandre Oliva wrote:

>> Then maybe this is the fundamental problem.  As long as the kernel
>> doesn't recognize that an ABI is a contract, rather than an
>> imposition, kernel developers won't care.

> That's a silly analogy. Worse, it's a very flawed analogy.

> If you want to use a legal analogy, the ABI is not a contract, it's a
> public _license_.

I didn't mean to use a legal analogy.  I meant contract in the
software engineering sense.  Sorry if that wasn't clear.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
