Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSGUVnT>; Sun, 21 Jul 2002 17:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSGUVnS>; Sun, 21 Jul 2002 17:43:18 -0400
Received: from verein.lst.de ([212.34.181.86]:42258 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S315179AbSGUVnS>;
	Sun, 21 Jul 2002 17:43:18 -0400
Date: Sun, 21 Jul 2002 23:46:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A9
Message-ID: <20020721234619.A10561@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
References: <Pine.LNX.4.44.0207212255130.27964-100000@localhost.localdomain> <Pine.LNX.4.44.0207212324330.28931-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207212324330.28931-100000@localhost.localdomain>; from mingo@elte.hu on Sun, Jul 21, 2002 at 11:26:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2002 at 11:26:40PM +0200, Ingo Molnar wrote:
> 
> the genhd.c bit is safe as well, removed the comment.

Is there any reason the sti is there at all?  In -dj almost all drivers
use module_init() now so it becomes increasingly useless..

