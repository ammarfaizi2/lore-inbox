Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267958AbUBRTee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 14:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267965AbUBRTee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 14:34:34 -0500
Received: from mx2.mail.ru ([194.67.23.22]:27153 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S267958AbUBRTed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 14:34:33 -0500
Message-ID: <4033BE48.1080900@mail.ru>
Date: Wed, 18 Feb 2004 23:34:32 +0400
From: rihad <rihad@mail.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: rivafb woes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't get rivafb to work on my GF-MX440! Am I wrong in thinking that
CONFIG_FB_RIVA is a drop-in faster replacement for CONFIG_FB_VESA? Or do
I need both of them compiled in? All I get when trying to boot is a
blank or a messed up screen. The penguin is there though :) Here's the
relevant lines of my lilo.conf:

vga=0x317
image=/boot/vmlinuz-2.6.3
       append="video=rivafb:1024x768-16@60"

$ lspci
[snip]
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX
440] (rev a3)

TIA!


