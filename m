Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVCCMyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVCCMyc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVCCMyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 07:54:31 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:11429 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261606AbVCCMxt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 07:53:49 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
References: <16923.193.128608.607599@jaguar.mkp.net>
	<20050303033704.6fb77a34.akpm@osdl.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 03 Mar 2005 07:53:37 -0500
In-Reply-To: <20050303033704.6fb77a34.akpm@osdl.org>
Message-ID: <yq0r7iwevqm.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> jes@trained-monkey.org (Jes Sorensen) wrote:
>>  This patch introduces ia64 specific read/write handlers for
>> /dev/mem access which is needed to avoid uncached pages to be
>> accessed through the cached kernel window which can lead to random
>> corruption.

Andrew> This patch causes hiccups on my ia32e box.

Andrew> linux:/home/akpm# /usr/sbin/hwscan --isapnp zsh: 7528
Andrew> segmentation fault

Weird, I'll take a look.

Thanks,
Jes

