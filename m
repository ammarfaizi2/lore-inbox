Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVI2AIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVI2AIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 20:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVI2AIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 20:08:17 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:35545 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1751145AbVI2AIQ (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 20:08:16 -0400
Message-ID: <433B306A.3000207@vc.cvut.cz>
Date: Thu, 29 Sep 2005 02:08:10 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.11) Gecko/20050914 Debian/1.7.11-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Bryan O'Sullivan" <bos@serpentine.com>
CC: ak@suse.de, discuss@x86-64.org, Linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2: x86_64 SMP kernel crashes early during boot
References: <1127949243.26892.41.camel@localhost.localdomain> <1127951120.26892.53.camel@localhost.localdomain>
In-Reply-To: <1127951120.26892.53.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan wrote:
> On Wed, 2005-09-28 at 16:14 -0700, Bryan O'Sullivan wrote:
> 
>>This is on a dual Opteron system, running Fedora Core 3.
> 
> 
> The oops is slightly different with 2.6.14-rc1, but still very early
> during boot, and still in mm/slab.c.

Take a look at this (in the '2.6.14-rc1-git-now still dying in mm/slab.c - this 
time line 1849).  Hopefully it will fix it once and forever (unfortunately my 
testing box did not surive testing and requires manual intervention at reset 
button).

http://groups.google.com/group/linux.kernel/tree/browse_frm/thread/b91bb66e5e372eda/e9101f3dccc47cff?rnum=21&hl=en&q=mm%2Fslab.c+1849&_done=%2Fgroup%2Flinux.kernel%2Fbrowse_frm%2Fthread%2Fb91bb66e5e372eda%2Fe8c08c1605a7e488%3Ftvc%3D1%26q%3Dmm%2Fslab.c+1849%26hl%3Den%26#doc_b567f8975faa9f3c

								Petr

