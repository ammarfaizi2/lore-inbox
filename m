Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751906AbWI1Nvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbWI1Nvo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbWI1Nvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:51:44 -0400
Received: from main.gmane.org ([80.91.229.2]:40920 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751906AbWI1Nvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:51:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Jellinghaus <aj@ciphirelabs.com>
Subject: Re: [ACRYPTO] New asynchronous crypto layer (acrypto) release.
Date: Thu, 28 Sep 2006 15:23:43 +0200
Message-ID: <451BCCDF.5000201@ciphirelabs.com>
References: <20060928120826.GA18063@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org
X-Gmane-NNTP-Posting-Host: ciphirelabs.net
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
In-Reply-To: <20060928120826.GA18063@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> Hello.
> 
> I'm pleased to announce asynchronous crypto layer (acrypto) [1] release 
> for 2.6.18 kernel tree. Acrypto allows to handle crypto requests 
> asynchronously in hardware.
> 
> Combined patchset includes:
>  * acrypto core
>  * IPsec ESP4 port to acrypto
>  * dm-crypt port to acrypto

so I should be able to replace a plain 2.6.18 kernel with one
with this patchset and use dm-crypt'ed partitions (e.g. swap,
encrypted root filesystem) as usual without further changes?

Did anyone test this with success?

Regards, Andreas

