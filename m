Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265844AbTFVUGr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 16:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265863AbTFVUGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 16:06:47 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:30376 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265844AbTFVUGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 16:06:47 -0400
Date: Sun, 22 Jun 2003 22:20:44 +0200
From: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
To: Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.72 doesn't boot
Message-ID: <20030622222044.A24129@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
	linux-kernel@vger.kernel.org
References: <3EF5EFEE.5050305@dhl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EF5EFEE.5050305@dhl.com>; from Bart.SCHELSTRAETE@dhl.com on Sun, Jun 22, 2003 at 08:05:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Today I tried kernel 2.5.72. And it compiled without any problems. (on a 
> i686 - PIV)
> But when I'm trying to boot from that kernel, it stops just after the line
>          'uncompressing .................. ok now booting'

You gotta have the input device support (CONFIG_INPUT) built-in to be able to
select virtual terminal (CONFIG_VT) and console on VT (CONFIG_VT_CONSOLE)
support found in character devices submenu. You'll also need a driver, "VGA
text console" (CONFIG_VGA_CONSOLE) will do.

Hope it helps.

Rudo.
