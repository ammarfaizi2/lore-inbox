Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031039AbWKUQWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031039AbWKUQWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 11:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031044AbWKUQWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 11:22:04 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:33754 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1031039AbWKUQWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 11:22:03 -0500
Message-ID: <456327B4.6000904@oracle.com>
Date: Tue, 21 Nov 2006 08:22:12 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: "Myaskouvskey, Artiom" <artiom.myaskouvskey@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc6-git2] EFI: mapping memory region of runtime
 services when using memmap kernel parameter
References: <C1467C8B168BCF40ACEC2324C1A2B074A6A6A5@hasmsx411.ger.corp.intel.com>
In-Reply-To: <C1467C8B168BCF40ACEC2324C1A2B074A6A6A5@hasmsx411.ger.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Myaskouvskey, Artiom wrote:
> From: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
> 
> When using memmap kernel parameter in EFI boot we should also add to memory map 
> memory regions of runtime services to enable their mapping later.
> 
> Signed-off-by: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
> ---

Thanks, I can actually apply the patch now, as opposed to the apparently
base64-encoded version that was just junk to me.

Of course, we can't review it easily when it's an attachment.
It would be a Good Thing for you to experiment with some email clients
that can send patches inline (not as attachments, not as base64) and
which do not mangle the whitespace and do not encode the text.

Back to the patch:  it's only for i386.  Does x86_64 need
similar treatment?

-- 
~Randy
