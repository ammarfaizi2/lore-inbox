Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751810AbWFAGSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWFAGSI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 02:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWFAGSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 02:18:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:20151
	"EHLO sunset.sfo1.dsl.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751810AbWFAGSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 02:18:07 -0400
Date: Wed, 31 May 2006 23:18:39 -0700 (PDT)
Message-Id: <20060531.231839.10909081.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: draghuram@rocketmail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, bidulock@openss7.org
Subject: Re: Question about tcp hash function tcp_hashfn()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060601061234.GB28087@2ka.mipt.ru>
References: <20060531130615.GA32362@2ka.mipt.ru>
	<20060531122955.B10147@openss7.org>
	<20060601061234.GB28087@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Thu, 1 Jun 2006 10:12:36 +0400

> I've present the new simple code and test results which show
> that folded and not folded Jenkins hashes _do_ produce _exactly_ the
> same distribution.

Ok I believe you now :)

> I think I've already said that fairly distributed values being xored
> produce still fairly distributed value, so parts of 32bit fairly
> distributed hash after being xored with each other still produce fairly
> distributed 32bit space.

It would make a good research paper for someone mathmatically
inclined enough :)
