Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWIPXBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWIPXBY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 19:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWIPXBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 19:01:24 -0400
Received: from mail.aiken.cz ([82.208.4.206]:687 "EHLO mail.aiken.cz")
	by vger.kernel.org with ESMTP id S964826AbWIPXBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 19:01:23 -0400
Message-ID: <450C8243.60406@kernel-api.org>
Date: Sun, 17 Sep 2006 01:01:23 +0200
From: Lukas Jelinek <info@kernel-api.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; cs-CZ; rv:1.7.12) Gecko/20050915
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: System restart
References: <20060916213849.GJ3051@mail.muni.cz>
In-Reply-To: <20060916213849.GJ3051@mail.muni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> 
> after upgrading BIOS to the latest version on my Intel Core 2 Duo with DP965LT 
> board kernel is unable to restart system. (Kernel 2.6.18-rc6.) With older BIOS
> the same kernel restarts OK. The last message printed on console is: Restarting
> system and system hangs.
> 
> I wonder, why "machine restart" message does not appear.
> 
> I tried kernel parameter reboot=t reboot=f reboot=t,w,f nothing helps.
> 

This is probably not a kernel problem but a BIOS-related one. Since only
a few boards/BIOSes need specific fixups it looks like your new BIOS is
buggy. Try to contact the BIOS vendor and report this problem.

Lukas Jelinek
