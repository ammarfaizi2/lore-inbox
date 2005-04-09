Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVDIGaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVDIGaQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 02:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVDIGaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 02:30:15 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:56233 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261298AbVDIG36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 02:29:58 -0400
Date: Sat, 9 Apr 2005 10:29:26 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jay Lan <jlan@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, aquynh@gmail.com,
       dean-list-linux-kernel@arctic.org, pj@sgi.com
Subject: Re: [patch 2.6.12-rc1-mm4] fork_connector: add a fork connector
Message-ID: <20050409102926.0cbf031c@zanzibar.2ka.mipt.ru>
In-Reply-To: <42574C88.9080601@engr.sgi.com>
References: <1112277542.20919.215.camel@frecb000711.frec.bull.fr>
	<20050331144428.7bbb4b32.akpm@osdl.org>
	<424C9177.1070404@engr.sgi.com>
	<1112341968.9334.109.camel@uganda>
	<4255B6D2.7050102@engr.sgi.com>
	<4255B868.6040600@engr.sgi.com>
	<1112955840.28858.236.camel@uganda>
	<1112957563.28858.240.camel@uganda>
	<4256E940.9050306@engr.sgi.com>
	<425700CD.5040906@engr.sgi.com>
	<20050409021856.39e99bef@zanzibar.2ka.mipt.ru>
	<42574C88.9080601@engr.sgi.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Sat, 09 Apr 2005 10:29:27 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Apr 2005 20:31:20 -0700
Jay Lan <jlan@engr.sgi.com> wrote:

> With the patch you provide to me, i did not see the bugcheck
> at cn_queue_wrapper() at the console.
> 
> Unmatched sequence number messages still happened. We expect
> to lose packets under system stressed situation, but i still
> observed duplicate messages, which concerned me.

What tool and what version do you use 
as message generator and receiver?

> Thanks,
>   - jay

	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
