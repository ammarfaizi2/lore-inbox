Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbTGLAti (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 20:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbTGLAth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 20:49:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27083 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267314AbTGLAt2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 20:49:28 -0400
Message-ID: <3F0F5E7E.5030000@pobox.com>
Date: Fri, 11 Jul 2003 21:03:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>
CC: Robert Love <rml@tech9.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
References: <20030711140219.GB16433@suse.de> <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk> <1057944829.6808.5.camel@localhost> <20030712003856.GB2904@ip68-4-255-84.oc.oc.cox.net>
In-Reply-To: <20030712003856.GB2904@ip68-4-255-84.oc.oc.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry K. Nathan wrote:
> On Fri, Jul 11, 2003 at 10:33:50AM -0700, Robert Love wrote:
> 
>>On Fri, 2003-07-11 at 07:26, Alan Cox wrote:
>>
>>
>>>or upgrade to rpm 4.2 (which I'd recommend everyone does anyway as it
>>>fixes a load of other problems) - ftp.rpm.org
>>
>>I think the 2.5 problem is _only_ in rpm 4.2.
>>
>>It looks like it is still in the latest version, too:
>>
>>[10:32:41]root@phantasy:~# rpm -q rpm
>>rpm-4.2.1-0.11
>>[10:32:44]root@phantasy:~# rpm --rebuilddb
>>error: db4 error(16) from dbenv->remove: Device or resource busy
> 
> 
> That's not the 2.5 problem. This one also happens with Red Hat's own
> 2.4 vendor kernels for Red Hat 9, and according to RPM's maintainer
> it's a "harmless" message.


Well, speaking with the rpm maintainer today, there are still issues 
with O_DIRECT (db4) and NPTL.

	Jeff



