Return-Path: <linux-kernel-owner+w=401wt.eu-S932739AbXABKZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbXABKZ7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 05:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbXABKZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 05:25:59 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60844 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932756AbXABKZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 05:25:58 -0500
Date: Tue, 2 Jan 2007 10:36:02 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] quiet MMCONFIG related printks
Message-ID: <20070102103602.28a873ea@localhost.localdomain>
In-Reply-To: <200701012101.38427.jbarnes@virtuousgeek.org>
References: <200701012101.38427.jbarnes@virtuousgeek.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2007 21:01:38 -0800
Jesse Barnes <jbarnes@virtuousgeek.org> wrote:

> Using MMCONFIG for PCI config space access is simply an optimization, not
> a requirement.  Therefore, when it can't be used, there's no need for

Some hardware reqires MCFG. In addition this is an error, a real error on
the vendors part or ours and could indicate there are many other BIOS
problems outstanding.

We shouldn't keep quiet about serious errors in tables, we need people to
know and be able to take appropriate action (eg new BIOSen, refusing
certifications etc).


NAK
