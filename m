Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbSL2XfV>; Sun, 29 Dec 2002 18:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbSL2XfU>; Sun, 29 Dec 2002 18:35:20 -0500
Received: from holomorphy.com ([66.224.33.161]:55781 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262266AbSL2XfT>;
	Sun, 29 Dec 2002 18:35:19 -0500
Date: Sun, 29 Dec 2002 15:42:03 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Christoph Hellwig <hch@lst.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove CONFIG_X86_NUMA
Message-ID: <20021229234203.GM9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Christoph Hellwig <hch@lst.de>,
	James Bottomley <James.Bottomley@steeleye.com>,
	linux-kernel@vger.kernel.org
References: <200212292239.gBTMdPJ12407@localhost.localdomain> <20021229234051.A12535@lst.de> <78170000.1041202589@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78170000.1041202589@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, someone had their attribution removed from:
>> I already wondered about that, but AFAIK a kernel with X86_NUMAQ set
>> still boots on a PeeCee, so it's really an option, not a choice.

On Sun, Dec 29, 2002 at 02:56:40PM -0800, Martin J. Bligh wrote:
> Nope, it won't boot on a PC - you're probably thinking of Summit,
> which should. I think Bill had a patch to move NUMA-Q already ...
> want to publish that one?

It's just moving the 2 config decls inside the choice/endchoice bracket,
not worth bothering with if it's getting fixed anyway.


Bill
