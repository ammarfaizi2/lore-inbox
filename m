Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbWIJAN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbWIJAN2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 20:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWIJAN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 20:13:28 -0400
Received: from bbr254.neoplus.adsl.tpnet.pl ([83.27.207.254]:25496 "EHLO
	Jerry.zjeby.dyndns.org") by vger.kernel.org with ESMTP
	id S965044AbWIJAN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 20:13:27 -0400
Date: Sun, 10 Sep 2006 02:13:13 +0200 (CEST)
From: curious <curious@zjeby.dyndns.org>
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: swsusp problem
Message-ID: <Pine.LNX.4.63.0609100119180.2685@Jerry.zjeby.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello.
i write because swsuspend don't work for me.
i try to echo disk > /sys/power/state
and just nothing happens, i have blinking cursor and machine freezes.

when i enabled debug i got :
stopping tasks: ========|
Shrinking memory... done (2684 pages freed)
swsusp: Need to copy 1454 pages
swsusp: critical section/: done (1454 pages copied)

.... and machine just sits there , doing nothing.
after reboot it boots like usual.

machine is Ts30M Viglen Dossier 486 SM
kernel is 2.6.18-rc5
here is config : http://zjeby.dyndns.org:8242/viglen.config



-- 
