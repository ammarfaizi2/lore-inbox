Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVDLL22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVDLL22 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVDLL1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:27:32 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:13265 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262280AbVDLKyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:54:38 -0400
X-ME-UUID: 20050412105437305.4A77C1C00246@mwinf0506.wanadoo.fr
Date: Tue, 12 Apr 2005 12:49:30 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Fabio Massimo Di Nitto <fabbione@ubuntu.com>,
       Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [PATCH] ppc32: MV643XX ethernet is an option for Pegasos
Message-ID: <20050412104930.GC12844@pegasos>
References: <1113289985.21548.66.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1113289985.21548.66.camel@gaston>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 05:13:04PM +1000, Benjamin Herrenschmidt wrote:
> Hi !
> 
> This patch allows Kconfig to build the MV643xx ethernet driver on
> Pegasos (CONFIG_PPC_MULTIPLATFORM) and adds what I think is a missing
> fix from Dale's batch, that is remove SA_INTERRUPT and add SA_SHIRQ in
> there as the interrupt is shared if I understand things correctly.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Fabio Massimo Di Nitto <fabbione@ubuntu.com>

Well, it originated by me/you/dale, but i think it is trivial stuff anyway.

Friendly,

Sven Luther

