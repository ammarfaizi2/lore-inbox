Return-Path: <linux-kernel-owner+w=401wt.eu-S1161171AbWLPQgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbWLPQgl (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 11:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161172AbWLPQgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 11:36:41 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:34799 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161171AbWLPQgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 11:36:40 -0500
Message-ID: <45842095.5040107@garzik.org>
Date: Sat, 16 Dec 2006 11:36:37 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] more ftape removal
References: <20061213130515.GB3851@stusta.de>
In-Reply-To: <20061213130515.GB3851@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch removes some more ftape code.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

this affects userspace exported headers, so I'm not sure we want to kill 
that.  even if the interface is gone is current kernels, people might 
want to build binaries against these headers that work on older kernels.

	Jeff



