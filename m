Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267262AbUBMWjh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267263AbUBMWjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:39:36 -0500
Received: from pxy1allmi.all.mi.charter.com ([24.247.15.38]:61129 "EHLO
	proxy1.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S267262AbUBMWit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:38:49 -0500
Message-ID: <402D528E.5070105@quark.didntduck.org>
Date: Fri, 13 Feb 2004 17:41:18 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: RANDAZZO@ddc-web.com
CC: linux-kernel@vger.kernel.org
Subject: Re: FW: spinlocks dont work
References: <89760D3F308BD41183B000508BAFAC4104B16F74@DDCNYNTD>
In-Reply-To: <89760D3F308BD41183B000508BAFAC4104B16F74@DDCNYNTD>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RANDAZZO@ddc-web.com wrote:
> On a uniprocessor system, with config_smp NOT Defined...
> 
> Note the following example:
> 
> driver 'A' calls spin_lock_irqsave and gets through (but does not call
> ..unlock).
> driver 'B' calls spin_lock_irqsave and gets through???
> 
> How can B get through if A did not unlock yet?
> 

On UP, spinlocks are no-ops.

--
				Brian Gerst
