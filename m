Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVAOBo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVAOBo2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVAOBmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:42:04 -0500
Received: from [81.2.110.250] ([81.2.110.250]:34793 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262095AbVAOBiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:38:03 -0500
Subject: Re: Linux 2.6.10-ac9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sami Farin <7atbggg02@sneakemail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050114030135.GA6032@m.safari.iki.fi>
References: <1105636996.4644.70.camel@localhost.localdomain>
	 <20050114030135.GA6032@m.safari.iki.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105743716.9839.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 15 Jan 2005 00:32:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-14 at 03:01, Sami Farin wrote:
> at this spot I have no /dev/dsp etc.
> then I reload snd_ens1371:

That sounds like the new udev rather than kernel side. The changes from
ac8 to ac9 are tiny on the audio side and don't involve driver setup
stuff.

> also, with 2.6.10 I can't disable write cache...
> I could do it in 2.6.9.

Works for me in 2.6.10-ac. Are there any diagnostics on dmesg when you
try and turn the cache off ?
 
