Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVBQRdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVBQRdq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 12:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVBQRdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 12:33:45 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:4531 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262315AbVBQRcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 12:32:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WEeWs+XnJAWndbeCTHjFz82JVlXe/FkrxCa1yKwabmw84jzZBY+krWjYRLphmMkwofXIm4yyzQTVE8eAFHnAcoiCVycdx8irQ/t1dp2Xgr4jBqfT6tJVg7gCO7IW9HMkpqIV/yI8cP/Tec+LTmNZ8RNrBZTfcB9GONq65r4Noqo=
Message-ID: <9e47339105021709327a9008b3@mail.gmail.com>
Date: Thu, 17 Feb 2005 12:32:06 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@sgi.com>
Subject: Re: pci_map_rom bug?
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200502170914.04305.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502161600.48252.jbarnes@sgi.com>
	 <9e473391050217082963f6ce50@mail.gmail.com>
	 <200502170914.04305.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2005 09:14:04 -0800, Jesse Barnes <jbarnes@sgi.com> wrote:
> Ah, ok, but we still have the situation that cause me to post the cleanup
> patch in the first place--pci_map_rom succeeds, but the first two bytes
> aren't 0x55aa but 0x0303...  Any ideas?

Check for returned size of zero and ignore the ROM?

> 
> Jesse
> 


-- 
Jon Smirl
jonsmirl@gmail.com
