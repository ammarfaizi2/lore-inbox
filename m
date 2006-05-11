Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWEKOWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWEKOWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 10:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWEKOWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 10:22:20 -0400
Received: from mx1.suse.de ([195.135.220.2]:21668 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750812AbWEKOWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 10:22:20 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/4] KBUILD: export-symbol usage report generator
Date: Thu, 11 May 2006 16:13:57 +0200
User-Agent: KMail/1.9.1
Cc: Ram Pai <linuxram@us.ibm.com>, agruen@suse.de, akpm@osdl.org,
       arjan@infradead.org, bunk@stusta.de, greg@kroah.com,
       jbeulich@novell.com, linux-kernel@vger.kernel.org, mathur@us.ibm.com
References: <20060510235546.8A006470034@localhost> <p73r7307pnk.fsf@bragg.suse.de> <20060511134318.GA7667@infradead.org>
In-Reply-To: <20060511134318.GA7667@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605111613.57718.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'd go even further and say every symbol should have a category. 

That would be a _lot_ of work. I was thinking more for some specialized
symbols first where the meaning is very clear. Also someone has to 
write the infrastructure first.

> These 
> catgories than could get labels such as mostly stable

I don't labels like "stable" etc. very much because it would give false
expectations to external users.

-Andi
