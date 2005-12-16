Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVLPT6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVLPT6r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVLPT6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:58:47 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:925 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932392AbVLPT6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:58:46 -0500
Subject: Re: Fwd: [2.6 patch] i386: always use 4k stacks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mike Snitzer <snitzer@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <170fa0d20512160917m7de06442x61bfbe3c3842fc2a@mail.gmail.com>
References: <20051215212447.GR23349@stusta.de>
	 <20051215140013.7d4ffd5b.akpm@osdl.org>
	 <20051216141002.2b54e87d.diegocg@gmail.com>
	 <1134751589.2992.43.camel@laptopd505.fenrus.org>
	 <170fa0d20512160902g26eefc2eua519617d3e760de@mail.gmail.com>
	 <170fa0d20512160917m7de06442x61bfbe3c3842fc2a@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Dec 2005 19:59:02 +0000
Message-Id: <1134763142.28761.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-12-16 at 12:17 -0500, Mike Snitzer wrote:
>  Any chance that IRQ stacks could be made available with 8K?  Set
> default to 4K but expose the _option_ for choice of 8K+IRQ stacks?  I
> realize it takes away from the fanatical push toward imposed 4K purity
> but Linux is really all about options.

That would just encourage people to be sloppy with their stack usage and
make the problem worse.

Alan

