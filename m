Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVBQR47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVBQR47 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 12:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVBQR47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 12:56:59 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:21041 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261167AbVBQR4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 12:56:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=SBeGfEQWJLTw/gT5WDTYdiMBrHp6MJQDHxPxmmqJZxTdC0gfUgiaCr+oXheMtEvWQ9ECTPL5TPCSed0zMhuGbb1XMKxsojHwoif+ZEfsIpUK6JMC/E6tyljoqxRMQHUqi7cQcr2cTjtOVnfxB3GYrfgunJsS+sE/EQTFXmqOVuI=
Message-ID: <9e4733910502170956e00a869@mail.gmail.com>
Date: Thu, 17 Feb 2005 12:56:51 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200502170945.30536.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502151557.06049.jbarnes@sgi.com>
	 <200502170929.54100.jbarnes@sgi.com>
	 <9e47339105021709321dc72ab2@mail.gmail.com>
	 <200502170945.30536.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2005 09:45:30 -0800, Jesse Barnes <jbarnes@sgi.com> wrote:
> Ok, how does this one look to you guys?  The r128 driver would need similar
> fixes.

Do any of the radeon ROMs store multiple images in different formats?
Should the radeon driver loop throught the ROM images looking for one
that it can understand, or is there alway only a single image? If ATI
wanted to they could make ROMs with both x86 and OpenFirmware images
on them.

-- 
Jon Smirl
jonsmirl@gmail.com
