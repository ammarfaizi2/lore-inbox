Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbTIKOEt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbTIKOEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:04:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18097 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261345AbTIKOE2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:04:28 -0400
Message-ID: <3F6080DD.3040509@pobox.com>
Date: Thu, 11 Sep 2003 10:04:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK-PATCH] kbuild: Separate output directory support
References: <20030911100514.GA14390@mars.ravnborg.org>
In-Reply-To: <20030911100514.GA14390@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> Usage is simple:
> cd /path/to/kernel/src
> mkdir ~/build/kernel
> make O=~/build/kernel [Make options]
> Please note: The O= syntax must be used for ALL invocations of make.
[...]
> How it works:
> If the O= option is used, or KBUILD_OUTPUT is set then a second invocation
> of make happens in the output directory.
> The second invocation of make uses VPATH to tell make where to locate
> the files. Furthermore include options for gcc is modifyied to point
> both in the directory where the kernel src is located, and in the
> directory where the output files are located. The latter is used for
> generated .h files.


Sweet!  Thanks for all your hard work, Sam.

	Jeff



