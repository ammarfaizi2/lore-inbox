Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162210AbWLAXSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162210AbWLAXSQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162220AbWLAXSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:18:16 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:29826
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1162210AbWLAXSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:18:14 -0500
Date: Fri, 01 Dec 2006 15:18:21 -0800 (PST)
Message-Id: <20061201.151821.52117682.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: nickpiggin@yahoo.com.au, mingo@elte.hu, wenji@fnal.gov, akpm@osdl.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061201095306.GA21232@2ka.mipt.ru>
References: <20061130102205.GA20654@2ka.mipt.ru>
	<20061130.121443.116355312.davem@davemloft.net>
	<20061201095306.GA21232@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Fri, 1 Dec 2006 12:53:07 +0300

> Isn't it a step in direction of full tcp processing bound to process
> context? :)

:-)

Rather, it is just finer grained locking.
