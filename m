Return-Path: <linux-kernel-owner+w=401wt.eu-S936916AbWLITxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936916AbWLITxm (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 14:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937171AbWLITxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 14:53:42 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:27916 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936916AbWLITxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 14:53:42 -0500
Message-ID: <457B1380.7060807@oracle.com>
Date: Sat, 09 Dec 2006 11:50:24 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Michael Halcrow <mhalcrow@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       trevor.highland@gmail.com, tyhicks@ou.edu
Subject: Re: [PATCH 1/2] eCryptfs: Public key; transport mechanism
References: <20061206230638.GA9358@us.ibm.com>	<20061206215555.85d584ca.akpm@osdl.org>	<20061209110416.670170eb.randy.dunlap@oracle.com> <20061209112130.f3ba7f22.akpm@osdl.org>
In-Reply-To: <20061209112130.f3ba7f22.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sat, 9 Dec 2006 11:04:16 -0800
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> 
>>> ecryptfs now has a dependency upon netlink.  There's no CONFIG_NETLINK.  If
>>> CONFIG_NET=n && CONFIG_ECRYPTFS=y is possible, it won't build.
>> Then shouldn't ECRYPTFS depend on CONFIG_NET ?
> 
> yup, that's what I meant..

That's easy enough to fix, but I was hoping that driver or filesystem
maintainers would eventually use & heed Documentation/SubmitChecklist.  :(

-- 
~Randy
