Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269639AbTG1NOG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 09:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269617AbTG1NOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 09:14:06 -0400
Received: from [66.212.224.118] ([66.212.224.118]:58888 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S269639AbTG1NN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 09:13:58 -0400
Date: Mon, 28 Jul 2003 09:17:37 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Lenar =?iso-8859-15?q?L=F5hmus?= <lenar@vision.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1-mm1 hangs on boot
In-Reply-To: <200307220939.14436.lenar@vision.ee>
Message-ID: <Pine.LNX.4.53.0307280916090.31622@montezuma.mastecende.com>
References: <200307220939.14436.lenar@vision.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jul 2003, Lenar [iso-8859-15] Lõhmus wrote:

> Hi,
> 
> Wanted to try out 2.6.0-test1-mm1 but no luck.
> 
> The kernel doesn't boot. Right after saying "Ok, booting kernel..."
> it hangs and only hardware reset helps at this point. And yes, I have
> CONFIG_VT_CONSOLE. When vesafb was compiled in it seemed to switch
> screen resolution before hang (vga=791).

Missing some config options (you need CONFIG_VGA_CONSOLE), hopefully the 
defaults will get a bit more sane...

# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

	Zwane
-- 
function.linuxpower.ca
