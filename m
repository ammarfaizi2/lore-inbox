Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbVHIQ1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVHIQ1G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbVHIQ1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:27:06 -0400
Received: from graphe.net ([209.204.138.32]:33195 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S964861AbVHIQ1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:27:05 -0400
Date: Tue, 9 Aug 2005 09:27:03 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org, b.zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] ide-disk oopses on boot
In-Reply-To: <20050809132725.GA20397@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.62.0508090926150.12719@graphe.net>
References: <20050809132725.GA20397@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, Petr Vandrovec wrote:

>   Problem is that pci_dev may be NULL - and it is NULL for example with
> kernel I've just built, with amd IDE driver built as a module while with
> ide-disk built into the kernel.

Yes that was discussed extensively by Andi and me and finally fixed by 
Kiran's patch in 2.6.13-rc6.
