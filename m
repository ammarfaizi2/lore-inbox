Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263008AbUK0BsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbUK0BsL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbUK0Brb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:47:31 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263008AbUKZTiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:38:19 -0500
Subject: Re: [PATCH 1/2] pci: Block config access during BIST
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brian King <brking@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <419FD58A.3010309@us.ibm.com>
References: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>
	 <1100917635.9398.12.camel@localhost.localdomain>
	 <1100934567.3669.12.camel@gaston>
	 <1100954543.11822.8.camel@localhost.localdomain>
	 <419FD58A.3010309@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101137279.2756.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 24 Nov 2004 11:49:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-11-20 at 23:38, Brian King wrote:
> Alan Cox wrote:
> > Some of the Intel CPU's are very bad at lock handling so it is an issue.
> > Also most PCI config accesses nowdays go to onboard devices whose
> > behaviour may well be quite different to PCI anyway. PCI has become a
> > device management API.
> 
> Does this following patch address your issues with this patch, Alan?

Doesn't seem related to it

