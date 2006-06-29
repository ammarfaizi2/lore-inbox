Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWF2UDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWF2UDF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWF2UDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:03:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:39061
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932374AbWF2UDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:03:03 -0400
Date: Thu, 29 Jun 2006 13:03:02 -0700 (PDT)
Message-Id: <20060629.130302.84973515.davem@davemloft.net>
To: bunk@stusta.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make net/core/skbuff.c:skb_release_data() static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060629192020.GR19712@stusta.de>
References: <20060623105623.GT9111@stusta.de>
	<20060623.040115.108744369.davem@davemloft.net>
	<20060629192020.GR19712@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Thu, 29 Jun 2006 21:20:20 +0200

> On Fri, Jun 23, 2006 at 04:01:15AM -0700, David Miller wrote:
> > From: Adrian Bunk <bunk@stusta.de>
> > Date: Fri, 23 Jun 2006 12:56:23 +0200
> > 
> > > skb_release_data() no longer has any users in other files.
> > > 
> > > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > If you are going to do this, you need to remove the reference
> > in arch/x86_64/kernel/functionlist too.
> > 
> > Thanks.
> 
> Corrected patch below.

Applied, thanks.
