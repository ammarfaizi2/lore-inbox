Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267779AbUHMXxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267779AbUHMXxn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267773AbUHMXxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:53:43 -0400
Received: from monet.celtelplus.com ([217.113.64.7]:33214 "EHLO
	monet.celtelplus.com") by vger.kernel.org with ESMTP
	id S267779AbUHMXwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:52:01 -0400
Message-ID: <411D5417.9030708@celtelplus.com>
Date: Sat, 14 Aug 2004 01:51:51 +0200
From: Anand Buddhdev <anand@celtelplus.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: binfmt_misc trouble with kernel 2.6.7
References: <411CF503.40202@celtelplus.com> <1092435114.25002.32.camel@localhost.localdomain>
In-Reply-To: <1092435114.25002.32.camel@localhost.localdomain>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Gwe, 2004-08-13 at 18:06, Anand Buddhdev wrote:
> 
>>I created a Fedora bugzilla entry for this but I was told that this is a 
>>problem in the kernel upstream. Is this indeed a known problem, and is 
>>there a fix?
> 
> Its not a kernel problem but a configuration one. The Fedora Core setup
> relies on binfmt_misc being a module in order to automount the
> binfmt_misc file system. 

You're right. It's not a kernel bug at all. Up until fedora kernel 
2.6.6, binfmt_misc was compiled as a module, and was loaded only when 
the wine script was run. When they changed it to compiled-in in kernel 
2.6.7, they should have provided a script as part of the upgrade 
process. I've suggested that via bugzilla. Don't know if they will 
implement it.
