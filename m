Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751552AbWCXHH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbWCXHH5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 02:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbWCXHH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 02:07:56 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:64437
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751350AbWCXHH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 02:07:56 -0500
Date: Thu, 23 Mar 2006 23:06:49 -0800 (PST)
Message-Id: <20060323.230649.11516073.davem@davemloft.net>
To: arjan@infradead.org
Cc: yang.y.yi@gmail.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       johnpol@2ka.mipt.ru, matthltc@us.ibm.com
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector v3
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1143183541.2882.7.camel@laptopd505.fenrus.org>
References: <4423673C.7000008@gmail.com>
	<1143183541.2882.7.camel@laptopd505.fenrus.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>
Date: Fri, 24 Mar 2006 07:59:01 +0100

> then make the syslog part optional.. if it's not already!

Regardless I still think the filesystem events connector is a useful
facility.

Audit just has way too much crap in it, and it's so much nicer to have
tiny modules that are optimized for specific areas of activity over
something like audit that tries to do everything.
