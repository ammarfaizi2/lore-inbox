Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUDQFXS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 01:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263648AbUDQFXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 01:23:18 -0400
Received: from everest.2mbit.com ([24.123.221.2]:44685 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S263646AbUDQFXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 01:23:17 -0400
Message-ID: <4080BF45.2090705@greatcn.org>
Date: Sat, 17 Apr 2004 13:23:17 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
Organization: GreatCN.org & The Summit Open Source Develoment Group
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, zh-cn, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
X-Scan-Signature: 198a7e145b2f20f117ef3a7ea282ce03
X-SA-Exim-Connect-IP: 24.123.221.2
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: What's the purpose of (compiled)|(.o$$)|(..ng$$)|(LASH[RL]DI) ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 4.0 (built Tue, 16 Mar 2004 14:56:42 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

In the top Makefile,

526         $(NM) $@ | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] 
\)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map


What's the purpose of (compiled)|(.o$$)|(..ng$$)|(LASH[RL]DI) ?
It seems they're old stuff and no longer there. right?

thanks

-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

