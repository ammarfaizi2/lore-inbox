Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVCIRmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVCIRmD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 12:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVCIRmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 12:42:02 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:44794 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262103AbVCIRlp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 12:41:45 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [Linux-fbdev-devel] Re: [announce 7/7] fbsplash - documentation
Date: Wed, 9 Mar 2005 18:29:47 +0100
User-Agent: KMail/1.7.1
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Michal Januszewski <spock@gentoo.org>
References: <20050308021706.GH26249@spock.one.pl> <20050308223728.GA11065@spock.one.pl> <9e4733910503090854e245740@mail.gmail.com>
In-Reply-To: <9e4733910503090854e245740@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200503091829.48999.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Middeweken 09 März 2005 17:54, Jon Smirl wrote:

> framebuffer already has a class registered. check out /sys/class/grpahics.
> 
> You should be able to just call request_firmware and have it download
> your image whenever you need it. It doesn't have to be firmware,
> request_firmware will download anything.

Agreed, request_firmware() would be a really nice way to simplify the interface.
It might be more practical to use the /sys/class/tty/tty* object instead of
the /sys/class/graphics/fb* one, but I don't know enough about the console
subsystem to tell for sure.

 Arnd <><
