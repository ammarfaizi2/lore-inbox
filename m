Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268282AbUJJMav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268282AbUJJMav (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 08:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268279AbUJJMau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 08:30:50 -0400
Received: from main.gmane.org ([80.91.229.2]:29829 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268280AbUJJM3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 08:29:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: SDiZ <gmane@sdiz.net>
Subject: Re: Linux 2.6.9-rc3-mm3 kernel oops..
Date: Sun, 10 Oct 2004 20:29:11 +0800
Message-ID: <ckb9up$tr3$1@sea.gmane.org>
References: <ck935s$83k$1@sea.gmane.org> <20041009141647.14d91f34.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5-HKSCS
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: n218250164066.netvigator.com
User-Agent: Mozilla Thunderbird 0.6+ (Windows/20040912)
X-Accept-Language: zh-hk, zh-tw, en-us, en
In-Reply-To: <20041009141647.14d91f34.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> SDiZ <gmane@sdiz.net> wrote:
> 
>>I have just compiled  2.6.9-rc3-mm3 on gentoo linux,
>> When I start KDE, artsd dies and give this error:
> 
> 
> You'll need to do
> 
> cd /usr/src/linux
> wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/broken-out/optimize-profile-path-slightly.patch
> patch -R -p1 < optimize-profile-path-slightly.patch
> 

Thanks, this solve the problem

-- 

