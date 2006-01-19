Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbWASGge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbWASGge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 01:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWASGge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 01:36:34 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9144
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932578AbWASGgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 01:36:33 -0500
Date: Wed, 18 Jan 2006 22:36:29 -0800 (PST)
Message-Id: <20060118.223629.100108404.davem@davemloft.net>
To: sfr@canb.auug.org.au
Cc: dwmw2@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch
 removed from -mm tree
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060119171708.7f856b42.sfr@canb.auug.org.au>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
	<1137648119.30084.94.camel@localhost.localdomain>
	<20060119171708.7f856b42.sfr@canb.auug.org.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 19 Jan 2006 17:17:08 +1100

> Documentation/CodingStyle says:
> 
> The limit on the length of lines is 80 columns and this is a hard limit.
> 
> Statements longer than 80 columns will be broken into sensible chunks.
> Descendants are always substantially shorter than the parent and are placed
> substantially to the right. The same applies to function headers with a long
> argument list. Long strings are as well broken into shorter strings.

I wish there were an exception for function prototypes and definitions.
Why?  So grep actually works.

Hmmm, what args does function X take?  Let's try this:

bash$ git grep X

Oops, the args went past 80 columns and was split up, so I only
get the first few in the grep output.
