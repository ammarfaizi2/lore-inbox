Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWJVSgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWJVSgK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 14:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWJVSgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 14:36:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:16338 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750755AbWJVSgJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 14:36:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
Date: Sun, 22 Oct 2006 20:36:03 +0200
User-Agent: KMail/1.9.5
Cc: Christoph Hellwig <hch@infradead.org>, Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <4537818D.4060204@qumranet.com> <20061022175609.GA28152@infradead.org> <453BB1B0.7040500@qumranet.com>
In-Reply-To: <453BB1B0.7040500@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610222036.03455.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 20:00, Avi Kivity wrote:
> Existing installations?
>
> Dropping 32-bit host support would certainly kill a lot of #ifdefs and
> reduce the amount of testing needed.  It would also force me to upgrade
> my home machine.

Ok, but if you radically change the kernel<->user API, doesn't that mean
you have to upgrade in the same way? The 32 bit emulation mode in x86_64
is actually pretty complete, so it probably boils down to a kernel upgrade
for you, without having to touch any of the user space.

	Arnd <><
