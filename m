Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVA2TKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVA2TKz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVA2TJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:09:14 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:62414 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261538AbVA2TIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:08:12 -0500
Date: Fri, 28 Jan 2005 20:41:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Wiktor <victorjan@poczta.onet.pl>
Cc: Christian <evil@g-house.de>, linux-kernel@vger.kernel.org
Subject: Re: AT keyboard dead on 2.6
Message-ID: <20050128194118.GA2921@ucw.cz>
References: <41F11F79.3070509@poczta.onet.pl> <20050128142826.GA12137@ucw.cz> <41FA6C93.2000900@g-house.de> <41FA94FE.9080606@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FA94FE.9080606@poczta.onet.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 08:39:42PM +0100, Wiktor wrote:

> Hi, IT WORKED!
> 
> >Please try i8042.noaux=1. You say you're using a serial mouse in your
> >other e-mail, so the system may not have an AUX port yet the kernel
> >thinks it does. This may cause the keyboard to stop responding.
> 
> command line "linux-new init=/bin/bash i8042.noaux=1 atkbd.reset=1" 
> booted 2.6.8.1 kernel with working keyboard. reset succeded. If AUX port 
> is what not-keen-on-hardware people call PS/2 port, the problem is 
> solved. my mainboard has damaged PS/2 port - it is detected but it does 
> NOT work. Thanks for paying attention.
 
Yes, the AUX port and PS/2 mouse port are two names for the same thing.

Do you still need atkbd.reset=1?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
