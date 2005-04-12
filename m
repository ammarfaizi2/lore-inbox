Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVDLIXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVDLIXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 04:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVDLIXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 04:23:05 -0400
Received: from main.gmane.org ([80.91.229.2]:64159 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262048AbVDLIXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 04:23:01 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: 2.6.12-rc2-mm3
Date: Tue, 12 Apr 2005 10:21:42 +0200
Message-ID: <d3g091$2ic$1@sea.gmane.org>
References: <20050411012532.58593bc1.akpm@osdl.org>	<d3ehut$boi$1@sea.gmane.org> <20050411172226.19716a2c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 195.70.138.133.adsl.nextra.cz
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
In-Reply-To: <20050411172226.19716a2c.akpm@osdl.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz> wrote:
> 
>>Andrew Morton wrote:
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
>>
>>MPlayer randomly crashes in various pthread_* calls when using binary
>>codecs. 2.6.12-rc2-mm2 was ok. I tried to reverse
>>fix-crash-in-entrys-restore_all.patch, but it didn't help.
>>
> 
> 
> hm, could be anything.
> 
> Does 2.6.12-rc2 also fail?

looks like it's sched-unlocked-context-switches.patch. after reversing
it works fine.

-- 
Jindrich Makovicka

