Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbUKHXCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbUKHXCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 18:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbUKHXCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 18:02:38 -0500
Received: from ftpbox.mot.com ([129.188.136.101]:60384 "EHLO ftpbox.mot.com")
	by vger.kernel.org with ESMTP id S261290AbUKHXC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 18:02:27 -0500
In-Reply-To: <418FF992.8040604@mvista.com>
References: <418FF992.8040604@mvista.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <32E32A44-31DA-11D9-9BE7-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: "lkml" <linux-kernel@vger.kernel.org>, "akpm" <akpm@osdl.org>,
       <linuxppc-dev@ozlabs.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH][PPC32] Add setup_indirect_pci_nomap() routine
Date: Mon, 8 Nov 2004 17:02:01 -0600
To: "Mark A. Greer" <mgreer@mvista.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

Out of interest, why would we not want to ioremap the cfg addr/data 
registers?

- kumar

On Nov 8, 2004, at 4:56 PM, Mark A. Greer wrote:

> This patch adds a routine that sets up indirect pci config space access
> but doesn't ioremap the config space addr/data registers.
>
> Signed-off-by: Mark Greer <mgreer@mvista.com>
> <indirect_pci.patch>

