Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266139AbUFRQc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUFRQc2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 12:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266144AbUFRQc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 12:32:28 -0400
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:61312 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S266139AbUFRQcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 12:32:20 -0400
From: Andrew Walrond <andrew@walrond.org>
To: David Ford <david+challenge-response@blue-labs.org>
Subject: Re: Iptables-1.2.9/10 compile failure with linux 2.6.7 headers
Date: Fri, 18 Jun 2004 17:21:47 +0100
User-Agent: KMail/1.6
Cc: netfilter@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <200406181611.37890.andrew@walrond.org> <40D313DC.7000202@blue-labs.org>
In-Reply-To: <40D313DC.7000202@blue-labs.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406181721.47968.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "cenedra.walrond.org", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi David, On Friday 18 Jun 2004 17:10, David Ford
	wrote: > Iptables should be using linux-libc-headers headers instead of
	kernel > headers. Is this acquired knowledge, or new Netfilter policy?
	How dependant are the iptables tools on the specifc kernel running?
	[...] 
	Content analysis details:   (0.0 points, 7.5 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Friday 18 Jun 2004 17:10, David Ford wrote:
> Iptables should be using linux-libc-headers headers instead of kernel
> headers.

Is this acquired knowledge, or new Netfilter policy?
How dependant are the iptables tools on the specifc kernel running?

Ie
Can I build iptables for use on 2.6.7 kernel with 2.6.6 linux-libc-headers? 
(probably)

But could I build iptables for 2.6.7 kernel with 2.4.20 linux-libc-headers? 
(probably not?)

The INSTALL file states specifically to use 
KERNEL_DIR=<<where-you-built-your-kernel>>

Andrew
