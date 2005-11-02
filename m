Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbVKBSzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbVKBSzw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbVKBSzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:55:52 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:980 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965179AbVKBSzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:55:51 -0500
Subject: Re: SMP CPU affinity questions
From: Lee Revell <rlrevell@joe-job.com>
To: listmonkey@neo.relay-host.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051102175022.13637.qmail@neo.relay-host.net>
References: <20051102175022.13637.qmail@neo.relay-host.net>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 13:54:11 -0500
Message-Id: <1130957651.9163.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 17:50 +0000, listmonkey@neo.relay-host.net wrote:
> Hi-
> 
> I am trying to use a quad Opteron motherboard with SMP Kernel 2.6.5 for a quasi-real-time task.

2.6.5 is a terrible choice for soft realtime applications, the serious
work on making 2.6 a viable soft RT platform didn't even start until
around 2.6.8.  Try 2.6.12 or newer (ideally 2.6.14).

Lee

