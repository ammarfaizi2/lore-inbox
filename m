Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbVLHAAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbVLHAAd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 19:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVLHAAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 19:00:33 -0500
Received: from eden-out.rutgers.edu ([128.6.68.11]:53035 "EHLO
	narnia8.rutgers.edu") by vger.kernel.org with ESMTP id S965032AbVLHAAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 19:00:32 -0500
From: Michael Wu <flamingice@sourmilk.net>
To: netdev@vger.kernel.org
Subject: Re: Broadcom 43xx first results
Date: Wed, 7 Dec 2005 19:00:27 -0500
User-Agent: KMail/1.8.2
Cc: Jiri Benc <jbenc@suse.cz>, Christoph Hellwig <hch@infradead.org>,
       Joseph Jezak <josejx@gentoo.org>, mbuesch@freenet.de,
       linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051205191008.GA28433@infradead.org> <20051205203121.48241a08@griffin.suse.cz>
In-Reply-To: <20051205203121.48241a08@griffin.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512071900.27669.flamingice@sourmilk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 14:31, Jiri Benc wrote:
> > And Joseph &
> > friends are writing a module to support softmac cards in that framework,
> > which is one of the most urgently needed things right now, because all
> > the existing softmac frameworks don't work with that code.
>
> And authors of rtl8180 did it too. And authors of adm8211 too.
>
The softmac code that is still in adm8211 is actually based on an early 
version of the softmac code that Jouni made for Devicescape. The Devicescape 
code does much more useful stuff than the code currently in the kernel. Sure, 
I can and have been porting adm8211 to the new kernel stuff.. but it already 
works with a much more mature piece of softmac code. I see the use of Intel's 
802.11 code as a step backwards.

-Michael Wu
