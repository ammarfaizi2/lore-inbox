Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVDCXoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVDCXoG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 19:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVDCXoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 19:44:05 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:16256 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261959AbVDCXny
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 19:43:54 -0400
Message-ID: <42507F2F.1050405@rtr.ca>
Date: Sun, 03 Apr 2005 19:41:35 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Zan Lynx <zlynx@acm.org>
Cc: Greg KH <greg@kroah.com>, Aaron Gyes <floam@sh.nu>,
       Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
References: <1111886147.1495.3.camel@localhost>	 <490243b66dc7c3f592df7a7d0769dcb7@mac.com>	 <20050327181221.GB14502@kroah.com> <1112058277.14563.4.camel@localhost>	 <20050329033350.GA6990@kroah.com> <1112069010.12853.52.camel@localhost>
In-Reply-To: <1112069010.12853.52.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zan Lynx wrote:
>
> That does not really make sense, as the driver model code could be used
> for ndiswrapper, for example.  That would not make the Windows net
> drivers derived code of the Linux kernel.  ndiswrapper, yes it would be.
> Binary driver blobs, no.

The Windows net drivers are not (we believe) compiled using GPL'd
header files and their included macros, asm code, etc..

Probably all Linux binary drivers *are* compiled using GPL'd header files,
and thus are themselves subject to the GPL.

Cheers
