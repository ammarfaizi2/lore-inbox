Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751636AbWBWJKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbWBWJKm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 04:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWBWJKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 04:10:41 -0500
Received: from relay4.usu.ru ([194.226.235.39]:37598 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1751636AbWBWJKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 04:10:40 -0500
Message-ID: <43FD7C49.10302@ums.usu.ru>
Date: Thu, 23 Feb 2006 14:11:37 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1
References: <20060220042615.5af1bddc.akpm@osdl.org>	<43FC6B8F.4060601@ums.usu.ru> <20060222225325.10a71472.rdunlap@xenotime.net>
In-Reply-To: <20060222225325.10a71472.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.1.0; VDF: 6.33.1.20; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Wed, 22 Feb 2006 18:47:59 +0500 Alexander E. Patrakov wrote:
>> zcat: stdin: decompression OK, trailing garbage ignored
> 
> No other output?  what $ARCH?

No other output, the arch is i386, userspace is Debian Sarge.

> What did the .config file contain?  was it correct?

The end result was correct. The problematic kernel image (with the 
config in it) can be accessed at:

http://ums.usu.ru/~patrakov/vmlinuz-2.6.16-rc3-mm1-home

(please notify when I can erase it)

> so is the only problem the zcat warning message?

Yes.

> I tested extract-ikconfig several times without errors (on 2.6.16-rc4-mm1).

I will dig more into the problem today. Reverting extract-ikconfig-* 
patches didn't help.

-- 
Alexander E. Patrakov
