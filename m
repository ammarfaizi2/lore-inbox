Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268524AbUHXXm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268524AbUHXXm6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268506AbUHXXmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 19:42:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60338 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268524AbUHXXjc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 19:39:32 -0400
Message-ID: <412BD1A8.6080901@pobox.com>
Date: Tue, 24 Aug 2004 19:39:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i8259 shutdown method for i386
References: <m1y8ka6vz9.fsf@ebiederm.dsl.xmission.com> <20040824231654.GD12613@kroah.com>
In-Reply-To: <20040824231654.GD12613@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Aug 20, 2004 at 02:43:06AM -0600, Eric W. Biederman wrote:
> 
>>Greg, 
>>Now that you have added sys_device support to the generic
>>device support.  This patch to shutdown the i8259A interrupt
>>controller on reboot should now be safe.
> 
> 
> This didn't apply either.  Care to send a 2.6.9-rc1 version?


As long as you know the kernel version it was diff'd against, you should 
be able to use BitKeeper to merge it...  just clone -rv$old_version, 
apply patch, and then pull that clone into your mainline.

	Jeff


