Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUHBXqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUHBXqA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 19:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUHBXpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 19:45:46 -0400
Received: from pxy4allmi.all.mi.charter.com ([24.247.15.43]:54426 "EHLO
	proxy4.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S264503AbUHBXpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 19:45:32 -0400
Message-ID: <410ED20B.7010507@quark.didntduck.org>
Date: Mon, 02 Aug 2004 19:45:15 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: erik@rigtorp.com
CC: linux-kernel@vger.kernel.org
Subject: Re: pci power management
References: <20040802213309.GA28580@linux.nu>
In-Reply-To: <20040802213309.GA28580@linux.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-Information: 
X-Charter-Scan: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Rigtorp wrote:
> I think the kernel should put every unclaimed device on the pci bus into
> D3cold state. It can then be reactivated when a module is loaded. All pci
> drivers should also put any device it has claimed into D3 if it is unloaded.
> 
> Erik
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Some devices are still used even though they are not claimed by a kernel 
driver, ie. video cards and PCI/AGP bridges.

--
				Brian Gerst
