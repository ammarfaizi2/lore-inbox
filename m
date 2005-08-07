Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbVHGLNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbVHGLNN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 07:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbVHGLNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 07:13:12 -0400
Received: from [81.2.110.250] ([81.2.110.250]:30929 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751521AbVHGLNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 07:13:12 -0400
Subject: Re: Getting rid of SHMMAX/SHMALL ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
       cr@sap.com, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.61.0508041547500.4373@goblin.wat.veritas.com>
References: <20050804113941.GP8266@wotan.suse.de>
	 <Pine.LNX.4.61.0508041409540.3500@goblin.wat.veritas.com>
	 <20050804132338.GT8266@wotan.suse.de>
	 <20050804142040.GB22165@mea-ext.zmailer.org>
	 <Pine.LNX.4.61.0508041547500.4373@goblin.wat.veritas.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 07 Aug 2005 12:38:32 +0100
Message-Id: <1123414712.9464.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-08-04 at 15:48 +0100, Hugh Dickins wrote:
> On Thu, 4 Aug 2005, Matti Aarnio wrote:
> > 
> > SHM resources are non-swappable, thus I would not by default
> > let user programs go and allocate very much SHM spaces at all.
> 
> No, SHM resources are swappable.

Large limits as oracle needs still allows any user to clog up the box
completely. 
