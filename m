Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbUCLQyn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 11:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUCLQyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 11:54:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4504 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262311AbUCLQym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 11:54:42 -0500
Message-ID: <4051EB42.8060903@pobox.com>
Date: Fri, 12 Mar 2004 11:54:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, Eric Brower <ebrower@usa.net>
Subject: Re: [PATCH] ethtool.h should use userspace-accessible types
References: <40511868.4060109@usa.net> <m17jxqf2xf.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m17jxqf2xf.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Eric Brower <ebrower@usa.net> writes:
> 
> 
>>Attached is a patch to 2.4's ethtool.h to use appropriate, userspace-accessible
>>data types (__u8 and friends, rather than u8 and friends).
> 
> 
> Why there is no #ifdef __KERNEL__ in this header to make it userspace
> safe.


Because it's not needed.

	Jeff



