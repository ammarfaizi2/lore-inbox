Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbVA1TlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbVA1TlD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVA1Tgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:36:45 -0500
Received: from smtp6.poczta.onet.pl ([213.180.130.36]:2702 "EHLO
	smtp6.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S262806AbVA1TfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:35:23 -0500
Message-ID: <41FA94FE.9080606@poczta.onet.pl>
Date: Fri, 28 Jan 2005 20:39:42 +0100
From: Wiktor <victorjan@poczta.onet.pl>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian <evil@g-house.de>
CC: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: AT keyboard dead on 2.6
References: <41F11F79.3070509@poczta.onet.pl> <20050128142826.GA12137@ucw.cz> <41FA6C93.2000900@g-house.de>
In-Reply-To: <41FA6C93.2000900@g-house.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, IT WORKED!

> Please try i8042.noaux=1. You say you're using a serial mouse in your
> other e-mail, so the system may not have an AUX port yet the kernel
> thinks it does. This may cause the keyboard to stop responding.

command line "linux-new init=/bin/bash i8042.noaux=1 atkbd.reset=1" 
booted 2.6.8.1 kernel with working keyboard. reset succeded. If AUX port 
is what not-keen-on-hardware people call PS/2 port, the problem is 
solved. my mainboard has damaged PS/2 port - it is detected but it does 
NOT work. Thanks for paying attention.

---
May the Source be with you.
wixor (it's my nick)
