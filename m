Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVAOBv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVAOBv6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVAOBuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:50:04 -0500
Received: from [81.2.110.250] ([81.2.110.250]:55273 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262118AbVAOBlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:41:18 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: brking@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050113215044.GA1504@muc.de>
References: <41E2AC74.9090904@us.ibm.com> <20050110162950.GB14039@muc.de>
	 <41E3086D.90506@us.ibm.com>
	 <1105454259.15794.7.camel@localhost.localdomain>
	 <20050111173332.GA17077@muc.de>
	 <1105626399.4664.7.camel@localhost.localdomain>
	 <20050113180347.GB17600@muc.de>
	 <1105641991.4664.73.camel@localhost.localdomain>
	 <20050113202354.GA67143@muc.de>
	 <1105645491.4624.114.camel@localhost.localdomain>
	 <20050113215044.GA1504@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105743914.9222.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 15 Jan 2005 00:33:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 21:50, Andi Kleen wrote:
> I could see it as a problem when it happens on a bridge, but why
> should it be a problem when some arbitary, nothing to do with X
> leaf is temporarily not available? 

Because X will believe that PCI address range is free and right now in
some circumstances older X may want to play with PCI layout itself.

Alan

