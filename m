Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbUKWFr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbUKWFr5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 00:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUKWFpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 00:45:34 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:42958 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261370AbUKWFn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 00:43:57 -0500
Subject: Re: [2.6 patch] MODULE_PARM_: remove the __deprecated
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: rusty@rustcorp.com.au, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041122155619.GG19419@stusta.de>
References: <20041122155619.GG19419@stusta.de>
Content-Type: text/plain
Date: Tue, 23 Nov 2004 00:43:56 -0500
Message-Id: <1101188636.4245.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 16:56 +0100, Adrian Bunk wrote:
> MODULE_PARM_ might be deprecated.
> But there are still over 2000 places in the kernel where it's used.

Changing MODULE_PARM to module_param is not exactly rocket science.  You
could probably fix them all with a perl script.

Lee

