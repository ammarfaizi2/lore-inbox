Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbTGLAgR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 20:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267200AbTGLAgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 20:36:16 -0400
Received: from dp.samba.org ([66.70.73.150]:15059 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267186AbTGLAgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 20:36:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16143.19744.413495.444195@cargo.ozlabs.ibm.com>
Date: Sat, 12 Jul 2003 09:49:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: SECURITY - data leakage due to incorrect strncpy implementation
In-Reply-To: <1057961423.20637.68.camel@dhcp22.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0307112100240.843-100000@artax.karlin.mff.cuni.cz>
	<1057959932.20637.51.camel@dhcp22.swansea.linux.org.uk>
	<1057961423.20637.68.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> Unknown: alpha, ppc

PPC doesn't clear the rest of the destination, I'll fix it.

Paul.
