Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWIHWJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWIHWJW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWIHWJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:09:22 -0400
Received: from mms2.broadcom.com ([216.31.210.18]:20749 "EHLO
	mms2.broadcom.com") by vger.kernel.org with ESMTP id S1751120AbWIHWJU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:09:20 -0400
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Subject: Re: TG3 data corruption (TSO ?)
From: "Michael Chan" <mchan@broadcom.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       "Segher Boessenkool" <segher@kernel.crashing.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <1157751689.31071.97.camel@localhost.localdomain>
References: <1551EAE59135BE47B544934E30FC4FC093FB19@NT-IRVA-0751.brcm.ad.broadcom.com>
 <1157751689.31071.97.camel@localhost.localdomain>
Date: Fri, 08 Sep 2006 15:07:22 -0700
Message-ID: <1157753242.9584.4.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006090808; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230352E34353031453837422E303032312D412D;
 ENG=IBF; TS=20060908220914; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006090808_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 691F35823885646456-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-09 at 07:41 +1000, Benjamin Herrenschmidt wrote:

> As for the tcpdump output, well, I have a 3Gb file for now :) I need to do a bit of surgery on it to
> get only the interesting part. I'll try to do that later today (but it may have to wait for monday).
> 
Ben, We probably don't need the tcpdump anymore now that we know it's a
memory ordering issue.

