Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTH2Muz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 08:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbTH2Muz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 08:50:55 -0400
Received: from gw-nl6.philips.com ([212.153.235.103]:42384 "EHLO
	gw-nl6.philips.com") by vger.kernel.org with ESMTP id S261152AbTH2Mux
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 08:50:53 -0400
Message-ID: <3F4F4C7B.6060009@basmevissen.nl>
Date: Fri, 29 Aug 2003 14:52:11 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Boszormenyi Zoltan <zboszor@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm3
References: <3F4F22D3.9080104@freemail.hu>
In-Reply-To: <3F4F22D3.9080104@freemail.hu>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boszormenyi Zoltan wrote:

> Hi,
> 
> I tried to "make modules_install" on the compiled tree.
> It says:
> 
> # make modules_install
> Install a current version of module-init-tools
> See http://www.codemonkey.org.uk/post-halloween-2.5.txt
> make: *** [_modinst_] Error 1
> 
> But I have installed it! It's called modutils-2.4.25-8
> (was -5 previously) from RH rawhide, it works on older
> (2.6.0-test4-mm1) kernels.
> This modutils is united with module-init-tools-0.9.12,
> it reports version 2.4.25 but detects newer kernels and uses
> the new module interface.
> 
> I looked the kernel Makefile and found that it greps the version
> it gets from depmod -V and wants module-init-tools.
> My fix against the rawhide modutils is attached.
> 

Can you do a diff of the Makefile between 2.6.0-test4-mm1 and ...mm3

Regards,

Bas




