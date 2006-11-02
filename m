Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751816AbWKBFIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbWKBFIB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 00:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbWKBFIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 00:08:01 -0500
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:10159 "EHLO
	ausmtp06.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751816AbWKBFIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 00:08:01 -0500
Message-ID: <45497D1A.2080601@in.ibm.com>
Date: Thu, 02 Nov 2006 10:37:38 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Andrew Morton <akpm@osdl.org>, Thomas Graf <tgraf@suug.ch>,
       Shailabh Nagar <nagar@watson.ibm.com>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] taskstats: uglify^Woptimize reply assembling
References: <20061101182512.GA444@oleg>
In-Reply-To: <20061101182512.GA444@oleg>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> The last series.
> 
> Balbir, Shailabh, could you suggest me some user-space tests?

Hi, Oleg,

We generally use getdelays (see Documentation/accounting/getdelays.c)
for getting data of all running processes running on the system
frequently along with a stress suite like cerebrus (ctcs) running
on the side.


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
