Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030179AbWCHV5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbWCHV5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWCHV5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:57:38 -0500
Received: from mx.pathscale.com ([64.160.42.68]:64234 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1030179AbWCHV5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:57:36 -0500
Subject: Re: [PATCH] Define flush_wc, a way to flush write combining store
	buffers
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andi Kleen <ak@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, akpm@osdl.org,
       paulus@samba.org, bcrl@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <200603081521.19693.ak@suse.de>
References: <e27c8e0061e03594b3e1.1141853501@localhost.localdomain>
	 <1141853919.11221.183.camel@localhost.localdomain>
	 <1141854208.27555.1.camel@localhost.localdomain>
	 <200603081521.19693.ak@suse.de>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 13:57:54 -0800
Message-Id: <1141855075.27555.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 15:21 +0100, Andi Kleen wrote:

> I think doing it privately is the better solution because I don't think you 
> have established it has an universal semantic that works
> on all X86-64 systems.

No, I quoted chapter and verse of the relevant Intel and AMD x86_64 docs
for you, complete with URLs and page numbers so it wouldn't take any
effort to verify what I was asserting.

I don't know what else I could have done (it was enough for bcrl, at
least), and you have come up any with suggestions as to what *would*
satisfy you, so I'm stuck.

> And we don't have a portable way to do WC anyways, so there is 
> no portable way to use it.
> 
> So just put an ifdef in.

That's fine.  Whatever satisfies reviewers :-)

	<b

