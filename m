Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVASTcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVASTcN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 14:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVASTcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 14:32:13 -0500
Received: from smtp-out-02.utu.fi ([130.232.202.172]:13004 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S261863AbVASTcG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 14:32:06 -0500
Date: Wed, 19 Jan 2005 21:31:58 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: [RFC][PATCH] /proc/<pid>/rlimit
In-reply-to: <20050118204457.GA7824@ti64.telemetry-investments.com>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       linux-kernel@vger.kernel.org
Message-id: <200501192131.59252.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <20050118204457.GA7824@ti64.telemetry-investments.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 January 2005 22:44, Bill Rugolsky Jr. wrote:
> This patch against 2.6.11-rc1-bk6 adds /proc/<pid>/rlimit to export
> per-process resource limit settings.  It was written to help analyze
> daemon core dump size settings, but may be more generally useful.
> Tested on 2.6.10. Sample output:

A "cool feature" would be if you could do
echo nofile 8192 8192 >/proc/`pidof thatserverproess`/rlimit
:-)
