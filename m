Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVBQXDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVBQXDC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVBQXAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:00:13 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:33850 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261218AbVBQW70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 17:59:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=eSjgewXuTXluhhcnSSssiA9Yqgrw7uwiex4KlhkhqOIwDvt4gg+FDvfvNb4WzONjUu+h9hSp0A7H84A5utfCboHsa9sHEGEm2Fc0FpWKhqQ+NP4yqrXpg4ZGqbmYjCku2QVYax1a18dMCLcYQtI5Pn1exNCIoOnnAIURRVah0bQ=
Message-ID: <9e47339105021714593115dacf@mail.gmail.com>
Date: Thu, 17 Feb 2005 17:59:19 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Cc: Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1108680436.5665.9.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502151557.06049.jbarnes@sgi.com>
	 <200502170929.54100.jbarnes@sgi.com>
	 <9e47339105021709321dc72ab2@mail.gmail.com>
	 <200502170945.30536.jbarnes@sgi.com> <1108680436.5665.9.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005 09:47:15 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> We could provide additional helpers, like pci_find_rom_partition(),
> which takes the architecture code as an argument. It would check the
> signature, and iterate all "partitions" til it finds the proper
> architecture (or none).

The spec allows for it but has anyone actually seen a ROM with
multiple images in it? I haven't but I only work on x86.

-- 
Jon Smirl
jonsmirl@gmail.com
