Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVDEPmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVDEPmp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVDEPkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:40:55 -0400
Received: from dvhart.com ([64.146.134.43]:47755 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261773AbVDEPjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:39:04 -0400
Message-ID: <4252B1A9.3040005@gmail.com>
Date: Tue, 05 Apr 2005 08:41:29 -0700
From: Vernon Mauery <vmauery@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Jonas Diemer <diemer@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: security issue: hard disk lock
References: <200504041832.j34IW6PO030096@laptop11.inf.utfsm.cl>
In-Reply-To: <200504041832.j34IW6PO030096@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Jonas Diemer <diemer@gmx.de> said:
> 
> [...]
> 
> 
>>I figured there could be a kernel compiled-in option that will make the
>>kernel lock all drives found during bootup. then, a malicous program
>>would need to install a different kernel in order to harm the drive,
>>which would be much more secure.
> 
> 
> Doing it in initrd should be plenty of time, no need to involve the kernel.

Technically, according to the article, the only safe time to do it is in the BIOS or in one of their special safe CDs that freezes the drive before the boot loader loads.  This makes sense because a particularly malicious place to put something like this is a worm that attaches to your boot loader.  Then, even doing it in the kernel at boot time is too late.

--Vernon

