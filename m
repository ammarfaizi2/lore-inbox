Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbTHYCpQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 22:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbTHYCpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 22:45:15 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:64430 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261393AbTHYCpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 22:45:12 -0400
Date: Mon, 25 Aug 2003 11:45:58 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: cache limit
In-reply-to: <20030821234709.GD1040@matchmail.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <AC36AB3038685indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.04 (WinNT,501)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <20030821234709.GD1040@matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003 16:47:09 -0700, Mike Fedyk wrote:

>On Thu, Aug 21, 2003 at 09:49:45AM +0900, Takao Indoh wrote:
>> Actually, in the system I constructed(RedHat AdvancedServer2.1, kernel
>> 2.4.9based), the problem occurred due to pagecache. The system's maximum
>> response time had to be less than 4 seconds, but owing to the pagecache,
>> response time get uneven, and maximum time became 10 seconds.
>
>Please try the 2.4.18 based redhat kernel, or the 2.4-aa kernel.

I need a tuning parameter which can control pagecache
like /proc/sys/vm/pagecache, which RedHat Linux has.
The latest 2.4 or 2.5 standard kernel does not have such a parameter.
2.4.18 kernel or 2.4-aa kernel has a alternative method?

--------------------------------------------------
Takao Indoh
 E-Mail : indou.takao@soft.fujitsu.com
