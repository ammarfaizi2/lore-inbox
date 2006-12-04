Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758937AbWLDCfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758937AbWLDCfK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 21:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758959AbWLDCfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 21:35:09 -0500
Received: from mta11.adelphia.net ([68.168.78.205]:35476 "EHLO
	mta11.adelphia.net") by vger.kernel.org with ESMTP id S1758937AbWLDCfI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 21:35:08 -0500
Message-ID: <45738959.1000209@acm.org>
Date: Sun, 03 Dec 2006 20:35:05 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Joseph Barnett <jbarnett@motorola.com>
Subject: Re: [PATCH 9/12] IPMI: add pigeonpoint poweroff
References: <20061202043746.GE30531@localdomain> <20061203132618.d7d58f59.akpm@osdl.org>
In-Reply-To: <20061203132618.d7d58f59.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 1 Dec 2006 22:37:46 -0600
> Corey Minyard <minyard@acm.org> wrote:
>
>   
>> +static void (*atca_oem_poweroff_hook)(ipmi_user_t user) = NULL;
>>     
>
> Sometime, please go through the IPMI code looking for all these
> statically-allocated things which are initialised to 0 or NULL and remove
> all those intialisations?  They're unneeded, they increase the vmlinux
> image size and there are quite a number of them.  Thanks.
>   
I'll do that, thanks, and I'll work on the other changes you suggest.

Do you prefer patches to fold into the existing patches or new versions?

-Corey
