Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbRDXVTY>; Tue, 24 Apr 2001 17:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbRDXVTP>; Tue, 24 Apr 2001 17:19:15 -0400
Received: from [64.64.109.142] ([64.64.109.142]:10513 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S131205AbRDXVTJ>; Tue, 24 Apr 2001 17:19:09 -0400
Message-ID: <3AE5EDAC.AF06F124@didntduck.org>
Date: Tue, 24 Apr 2001 17:18:36 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Walter <srwalter@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] properly detect ActionTec modem of 
 PCI_CLASS_COMMUNICATION_OTHER
In-Reply-To: <20010424160310.A338@hapablap.dyn.dhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Walter wrote:
> 
> This patch allows the serial driver to properly detect and set up the
> ActionTec PCI modem.  This modem has a PCI class of COMMUNICATION_OTHER,
> which is why this modem is not otherwise detected.
> 
> Any suggestions on the patch are welcome.  Thanks

A small suggestion:  Vendor/device id are sufficient to identify the
device.  You can change PCI_CLASS_COMMUNICATION_OTHER << 8 to 0.

--

				Brian Gerst
