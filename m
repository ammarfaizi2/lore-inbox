Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbTILBOj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 21:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbTILBOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 21:14:39 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:30613 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261626AbTILBOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 21:14:39 -0400
Subject: Re: [2.6 PATCH] Squelch make mandocs warnings
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Still <mikal@stillhq.com>
Cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1063327887.3f61188f9947e@dubai.stillhq.com>
References: <1063327887.3f61188f9947e@dubai.stillhq.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063329183.4370.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Fri, 12 Sep 2003 02:13:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine. Technically xml docbook tags must be lower case but older
SGML docbook is undefined. The /tmp handling still does want fixing
though - it does several things that don't look remotely /tmp safe.

