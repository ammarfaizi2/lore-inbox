Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWJEVcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWJEVcO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWJEVcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:32:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:65464 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932224AbWJEVcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:32:13 -0400
Subject: Re: Really good idea to allow mmap(0, FIXED)?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200610052059.11714.mb@bu3sch.de>
References: <200610052059.11714.mb@bu3sch.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Oct 2006 22:58:00 +0100
Message-Id: <1160085480.1607.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-05 am 20:59 +0200, ysgrifennodd Michael Buesch:
> Is is really a good idea to allow processes to remap something
> to address 0?

It is very useful indeed. Consider for example dosemu.

> Besides that, I currently don't see a valid reason to mmap address 0.
> 
> Comments?

User zero is not neccessarily mapped at kernel zero so your argument
isn't portable either.


