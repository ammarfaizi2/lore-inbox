Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVJFO3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVJFO3E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbVJFO3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:29:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31716 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750989AbVJFO3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:29:01 -0400
Subject: Re: PAE causing failure to run various executables.
From: Arjan van de Ven <arjan@infradead.org>
To: Avi Kivity <avi@argo.co.il>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <43453433.7000308@argo.co.il>
References: <88056F38E9E48644A0F562A38C64FB6005EE9110@scsmsx403.amr.corp.intel.com>
	 <1128604838.2960.42.camel@laptopd505.fenrus.org>
	 <43453433.7000308@argo.co.il>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 16:28:55 +0200
Message-Id: <1128608936.2960.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-06 at 17:26 +0300, Avi Kivity wrote:
> Arjan van de Ven wrote:
> 
> >>Another possible reason can be NX(Execute Disable) support, which is 
> >>active only on a PAE kernel. Trying "noexec=off" on a PAE kernel can be
> >>tried here.
> >>    
> >>
> >
> >if that were the case them mem=4096M wouldn't solve the hangs..
> >
> >  
> >
> then bad memory is more likely. does mem= limit memory size to 4096MB, 
> or does it limit the maximum physical address?

highest phys address



