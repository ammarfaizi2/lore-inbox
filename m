Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267677AbUG3Vmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267677AbUG3Vmr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 17:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267695AbUG3Vmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 17:42:47 -0400
Received: from cantor.suse.de ([195.135.220.2]:64729 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267677AbUG3Vmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 17:42:46 -0400
Date: Fri, 30 Jul 2004 23:42:44 +0200
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] Improve pci_alloc_consistent wrapper on preemptive
 kernels
Message-Id: <20040730234244.16e9f99f.ak@suse.de>
In-Reply-To: <410A8E7D.2030009@pobox.com>
References: <20040730190227.29913e23.ak@suse.de>
	<410A826C.4000508@pobox.com>
	<20040730194304.2c27f48c.ak@suse.de>
	<410A8E7D.2030009@pobox.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2004 14:07:57 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:


> 
> Certainly.  Therefore, changing from GFP_ATOMIC will increase likelihood 
> of breakage, no?

No, except for places that are already broken on preemptive kernels
(and note this change only does something on preemptive kernels) 

-Andi
