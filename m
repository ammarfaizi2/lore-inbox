Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVAVSgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVAVSgA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 13:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVAVSgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 13:36:00 -0500
Received: from [81.2.110.250] ([81.2.110.250]:6016 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262614AbVAVSf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 13:35:57 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: brking@us.ibm.com
Cc: Andi Kleen <ak@muc.de>, paulus@samba.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41ED27CD.7010207@us.ibm.com>
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com>
	 <m14qhpxo2j.fsf@muc.de> <41E2AC74.9090904@us.ibm.com>
	 <20050110162950.GB14039@muc.de> <41E3086D.90506@us.ibm.com>
	 <1105454259.15794.7.camel@localhost.localdomain>
	 <20050111173332.GA17077@muc.de>
	 <1105626399.4664.7.camel@localhost.localdomain>
	 <20050113180347.GB17600@muc.de>
	 <1105641991.4664.73.camel@localhost.localdomain>
	 <20050113202354.GA67143@muc.de>  <41ED27CD.7010207@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106161249.3341.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 19 Jan 2005 22:40:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-18 at 15:14, Brian King wrote:
> Alan - are you satisfied with the most recent patch, or would you prefer 
> the patch not returning failure return codes and just bit bucketing 
> writes and returning all ff's on reads? Either way works for me.

Which was the last one. For userspace we need to block while we finish
the BIST.

