Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264781AbUHCAgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbUHCAgk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUHCAdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:33:10 -0400
Received: from the-village.bc.nu ([81.2.110.252]:28345 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264655AbUHCA3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:29:18 -0400
Subject: Re: DRM code reorganization
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@linux.ie>
Cc: Ian Romanick <idr@us.ibm.com>, Jon Smirl <jonsmirl@yahoo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0408030040030.27728@skynet>
References: <20040802155312.56128.qmail@web14923.mail.yahoo.com>
	 <410E81C3.2070804@us.ibm.com>  <Pine.LNX.4.58.0408030040030.27728@skynet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091489200.1668.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 03 Aug 2004 00:26:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-03 at 00:48, Dave Airlie wrote:
> I'm going to agree with Ian here, making a generic library layer is going
> to make maintaining  the DRM a full time job as opposed to the 5-6 hrs a

Disagree. If the factoring is done right its probably easier to maintain
and you'll have more people able to maintain it. In addition because its
not "magic" more code scans for bugs and the like will
find stuff properly.

> week I do on it ... also the change to a library needs to be done in
> little steps, removing something from one place and adding it to another,
> a big code-drop from the DRI CVS is not going to be acceptable to anyone,
> however breaking things in the kernel tree is also not going to be...

Its going to have to happen to get video stuff working, to get hotplug
working. The question is when and how we do it

