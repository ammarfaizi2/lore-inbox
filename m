Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264710AbTFEOrH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 10:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264712AbTFEOrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 10:47:06 -0400
Received: from air-2.osdl.org ([65.172.181.6]:58793 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264710AbTFEOrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 10:47:06 -0400
Subject: Re: megaraid in 2.5.70
From: Mark Haverkamp <markh@osdl.org>
To: hv-it <hv@trust-mart.com.cn>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030605150335.4acdc174.hv@trust-mart.com.cn>
References: <20030605150335.4acdc174.hv@trust-mart.com.cn>
Content-Type: text/plain
Organization: 
Message-Id: <1054825258.13060.17.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 Jun 2003 08:00:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 00:03, hv-it wrote:
> Hi,all:
>    megaraid's driver in 2.5.70 can make swapper pannic at boot time.So I copy 2.5.69's megaraid.c and megaraid.h to 2.5.70,all is right.I found that  "memset(mbox, 0, sizeof(mbox));" in 2.5.70 and " memset(mbox, 0, sizeof(mbox));" in 2.5.69,I wondered whether it's the pannic source.

It is.  A fix for this was checked in a couple days ago.

-- 
Mark Haverkamp <markh@osdl.org>

