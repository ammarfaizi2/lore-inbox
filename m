Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWA0LTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWA0LTY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 06:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWA0LTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 06:19:24 -0500
Received: from cantor2.suse.de ([195.135.220.15]:27085 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964970AbWA0LTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 06:19:23 -0500
Message-ID: <43DA01B1.8040504@suse.de>
Date: Fri, 27 Jan 2006 12:19:13 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/2] uml: enable drivers (input, fb, vt)
References: <43D64F05.90302@suse.de> <20060124213141.GA7891@ccure.user-mode-linux.org> <43D744B2.5030809@suse.de> <20060127035732.GA12763@ccure.user-mode-linux.org>
In-Reply-To: <20060127035732.GA12763@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> On Wed, Jan 25, 2006 at 10:28:18AM +0100, Gerd Hoffmann wrote:
>> Do you have "CONFIG_FRAMEBUFFER_CONSOLE=y" in .config?
> 
> Yup, here are all the option that look relevant:
> 
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_X11_FB=y
> CONFIG_X11_FB=y
> CONFIG_FB=y
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y

Looks ok.  What kernel command line do you boot the kernel with?  Any
console=something in there?  Any changes if you append "console=tty0"?

cheers,

  Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg
