Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWHVNvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWHVNvN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 09:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWHVNvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 09:51:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:60641 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932248AbWHVNvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 09:51:12 -0400
From: Andi Kleen <ak@muc.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 15:50:57 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1155202505.18420.5.camel@localhost.localdomain> <1156254965.27114.17.camel@localhost.localdomain> <1156254322.2976.55.camel@laptopd505.fenrus.org>
In-Reply-To: <1156254322.2976.55.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608221550.57603.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> this would need a "const after boot" section; which is really not hard
> to make and probably useful for a lot more things.... todo++

except for anything that needs tlb entries in user space. And it only gives you
false sense of security. --todo

-Andi
