Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTETTRl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 15:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263900AbTETTRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 15:17:41 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:26073 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263898AbTETTRj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 15:17:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16074.33371.411219.528228@gargle.gargle.HOWL>
Date: Tue, 20 May 2003 21:30:35 +0200
From: mikpe@csd.uu.se
To: Terence Ripperda <tripperda@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pat support in the kernel
In-Reply-To: <20030520185409.GB941@hygelac>
References: <20030520185409.GB941@hygelac>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda <tripperda@nvidia.com>, <tripperda@nvidia.com> writes:
 > Hello all,
 > 
 > I've discussed adding Page Attribute Table (PAT) support to the kernel w/ a few developers offline. They were very supportive and suggested I bring the discussion to lkml so others could get involved.

Not that I disagre with utilising the PAT, but I don't see anything in this code to
deal with the widespread PAT indexing erratum in Intel's processors. I don't have
the errata sheets here, but it definitely affected the PIIIs and I think also some P4s.
(Large pages ignoring PAT index bit 2, or something like that.)

/Mikael
