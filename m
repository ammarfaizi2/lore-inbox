Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWCULcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWCULcs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWCULcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:32:48 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:31651 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751178AbWCULcr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:32:47 -0500
Message-ID: <441FE465.1090602@us.ibm.com>
Date: Tue, 21 Mar 2006 06:32:53 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH 2.6.16-rc6-xen] export Xen Hypervisor attributes	to	sysfs
References: <200603202335.k2KNZEjo005673@mdday.raleigh.ibm.com>	 <1142925269.3077.10.camel@laptopd505.fenrus.org>  <441FD8F3.208@us.ibm.com> <1142939444.3077.55.camel@laptopd505.fenrus.org>
In-Reply-To: <1142939444.3077.55.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>> I appreciate the counter argument as well, but think this should be a 
>> configurable option. 
> 
> "a config option" is a cop-out. By proposing a config option you even
> admit it's not essential for userspace. The last thing this should be is
> a config option; it either is needed and important, and should be there
> always, or it's redundant and should be done in userspace. "A config
> option" is just admitting that it is the later, but that you need to
> justify the time you spent on the kernel patch somewhere ;-)

No, not at all. There are two types of Xen kernels: privileged and 
non-privileged. A privileged kernel has access to real hardware devices. 
This patch is intended for  privileged xen kernel. That's why it needs 
to be a configurable option.

Mike
