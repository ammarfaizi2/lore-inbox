Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUK3OFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUK3OFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 09:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbUK3OFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 09:05:22 -0500
Received: from baloney.puettmann.net ([194.97.54.34]:64687 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S262085AbUK3OFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 09:05:12 -0500
To: linux-kernel@vger.kernel.org, akpm@osdl.org, ganesh.venkatesan@intel.com
From: Ruben Puettmann <ruben@puettmann.net>
Subject: Re: 2.6.10-rc2-bk13 freeze on boot with e100 in HP DL360G1
In-Reply-To: <36g5n-am-29@gated-at.bofh.it>
References: <36g5n-am-29@gated-at.bofh.it>
Reply-To: ruben@puettmann.net
Date: Tue, 30 Nov 2004 15:00:54 +0100
Message-Id: <E1CZ8Yo-0004G0-00@baloney.puettmann.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                         hello,
>
> I try to boot the fresh 2.6.10-rc2-bk13 on an HP/Compaq DL360G1.=20
> (Config attached.) Boot parameter "elevator=3Dcfq pci=3Dnoacpi" or
> "elevator=3Dcfq" only.=20
>
> Last message on boot is :
>
> e100: Intel(R) PRO/100 Network Driver 3.2.3-k2-NAPI
> e100: Copyright(c) 1999-2004 Intel Corporation.
>
> System freezed.
>
> I have take a look in the last Changelog and found this Change:
>
> ChangeSet@1.2223.1.1, 2004-11-24 14:53:50-05:00, akpm@osdl.org
>   [PATCH] e100: early reset fix

ChangeSet@1.2249.1.1 makes it work thx. 

                Ruben

-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
