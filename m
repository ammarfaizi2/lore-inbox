Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965244AbWFAGXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244AbWFAGXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 02:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWFAGXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 02:23:44 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40348
	"EHLO sunset.sfo1.dsl.speakeasy.net") by vger.kernel.org with ESMTP
	id S965244AbWFAGXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 02:23:43 -0400
Date: Wed, 31 May 2006 23:24:15 -0700 (PDT)
Message-Id: <20060531.232415.38315104.davem@davemloft.net>
To: bidulock@openss7.org
Cc: johnpol@2ka.mipt.ru, draghuram@rocketmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060601002221.B21730@openss7.org>
References: <20060601061234.GB28087@2ka.mipt.ru>
	<20060531.231839.10909081.davem@davemloft.net>
	<20060601002221.B21730@openss7.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Brian F. G. Bidulock" <bidulock@openss7.org>
Date: Thu, 1 Jun 2006 00:22:21 -0600

> I thought you said you were considering jenkins_3word(), not
> jenkins_2word()?

We could xor some of the inputs in order to use jenkins_2word().
