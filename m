Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVFUWfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVFUWfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVFUWeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:34:46 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:36916 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262474AbVFUVzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:55:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WnIb6Bmt4j00bqUnKe9WInDlJZkCmzWNHNPhCYqtFen4UWn9h45cob4sAbieKDGYb7plquDTn5BXRm5rG/uBUNuRUfBK170Gh/D0G7yTRShYelL1xLeY6l7QFvra4HMlBpjBCCazU00oxoN1dY3DVGeU/16CMcP9IAcmIIkUNn8=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Grant Coady <grant_lkml@dodo.com.au>
Subject: Re: 2.6.12-mm1 breaks Toshiba laptop yenta cardbus
Date: Wed, 22 Jun 2005 02:01:07 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <s32db1toatpgar8nun4m5rtqq97hkbk2ab@4ax.com>
In-Reply-To: <s32db1toatpgar8nun4m5rtqq97hkbk2ab@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506220201.08134.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 June 2005 13:15, Grant Coady wrote:
> Yenta: CardBus bridge found at 0000:00:0b.0 [1179:0001]
> yenta 0000:00:0b.0: Preassigned resource 0 busy, reconfiguring...
> yenta 0000:00:0b.0: Preassigned resource 1 busy, reconfiguring...
> yenta 0000:00:0b.0: Preassigned resource 1 busy, reconfiguring...
> yenta 0000:00:0b.0: no resource of type 200 available, trying to continue...
> yenta 0000:00:0b.0: Preassigned resource 2 busy, reconfiguring...
> yenta 0000:00:0b.0: Preassigned resource 2 busy, reconfiguring...
> yenta 0000:00:0b.0: no resource of type 100 available, trying to continue...
> yenta 0000:00:0b.0: Preassigned resource 3 busy, reconfiguring...
> yenta 0000:00:0b.0: Preassigned resource 3 busy, reconfiguring...
> yenta 0000:00:0b.0: no resource of type 100 available, trying to continue...
> Yenta: ISA IRQ mask 0x04b8, PCI irq 11
> Socket status: 30000020
> 
> 2.6.12 okay
> 
> See:
>   http://scatter.mine.nu/test/linux-2.6/tosh/
> for config, dmesg, cpu, mem, ioports, etc

I've filed a bug at kernel bugzilla, so your report won't be lost.
See http://bugme.osdl.org/show_bug.cgi?id=4775
